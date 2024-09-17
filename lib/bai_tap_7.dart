import 'package:flutter/material.dart';

class BaiTap07 extends StatefulWidget {
  const BaiTap07({super.key});

  @override
  State<BaiTap07> createState() => _BaiTap07State();
}

class _BaiTap07State extends State<BaiTap07> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  List<int> divisible = []; // Danh sách chứa các số chia hết cho 3
  late AnimationController
      _animationController; // Controller để điều khiển animation
  late Animation<double> _animation; // Animation cho hiệu ứng scaling
  final GlobalKey<AnimatedListState> _listKey =
      GlobalKey<AnimatedListState>(); // Key để điều khiển AnimatedList
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Khởi tạo AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // Khởi tạo animation với hiệu ứng scaling
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Hàm tạo các số mới từ số n bằng cách xóa các chữ số liên tiếp
  Set<int> generateNumbers(int number) {
    String numtoStr = number.toString();
    Set<int> resultSet = {number}; // Khởi tạo tập với số ban đầu

    // Lặp qua tất cả các phần tử từ n
    for (int i = 0; i < numtoStr.length; i++) {
      for (int j = i + 1; j <= numtoStr.length; j++) {
        // Lấy một phần của chuỗi nStr và loại bỏ các số 0 ở đầu
        String sub = numtoStr.substring(0, i) + numtoStr.substring(j);

        // Nếu chuỗi con không rỗng, thêm số đó vào tập kết quả
        if (sub.isNotEmpty) {
          int num = int.parse(sub);
          // Loại bỏ các số có chữ số bắt đầu bằng 0
          if (sub.length == numtoStr.length - 1 || sub[0] != '0') {
            resultSet.add(num);
          }
        }
      }
    }

    return resultSet;
  }

  // Hàm tính các số chia hết cho 3
  void calculateDivisible() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        divisible.clear(); // Xóa danh sách cũ

        int number = int.parse(_controller.text); // Lấy số n từ người dùng
        Set<int> numberSet = generateNumbers(number); // Sinh các số từ n

        // Lặp qua tất cả các số trong tập D
        for (int num in numberSet) {
          if (num % 3 == 0) {
            // Nếu số đó chia hết cho 3
            divisible.add(num);
          }
        }

        // Cập nhật giao diện và thực hiện animation khi các số mới được thêm vào danh sách
        _updateList();
      });
    }
  }

  // Hàm cập nhật AnimatedList và thực hiện animation
  void _updateList() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    for (int i = 0; i < divisible.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        _listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 300));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính số chia hết cho 3'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number, // Bàn phím số
                  decoration: const InputDecoration(
                    labelText: "Nhập số nguyên n",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.input, color: Colors.teal),
                  ),
                  style: const TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số';
                    }
                    return null;
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateDivisible, // Nút để tính toán
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Màu chữ của nút
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo góc nút
                ),
              ),
              child: const Text(
                "Tính toán",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Có ${divisible.length} số chia hết cho 3:',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.blueAccent, // Thay đổi màu chữ nếu cần
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ScaleTransition(
                          scale: _animation,
                          child: ListTile(
                            title: GestureDetector(
                              child: Text(
                                '${divisible[index]}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontFamily: FontWeight.bold.toString(),
                                ),
                              ),
                            ),
                            leading: const Icon(Icons.numbers),
                            tileColor:
                                index.isEven ? Colors.blue[200] : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                          ),
                        );
                      },
                      childCount: divisible.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
