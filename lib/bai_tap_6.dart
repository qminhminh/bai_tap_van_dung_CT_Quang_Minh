// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class BaiTap06 extends StatefulWidget {
  const BaiTap06({super.key});

  @override
  State<BaiTap06> createState() => _BaiTap06State();
}

class _BaiTap06State extends State<BaiTap06> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  List<int> beautifulNumbers = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Hàm kiểm tra một số có phải là số nguyên tố hay không
  bool _isPrime(int n) {
    if (n < 2) return false; // Các số nhỏ hơn 2 không phải là số nguyên tố
    for (int i = 2; i * i <= n; i++) {
      // Kiểm tra tính chia hết từ 2 đến căn bậc hai của n
      if (n % i == 0)
        return false; // Nếu n chia hết cho i, thì n không phải là số nguyên tố
    }
    return true; // Nếu không tìm thấy số nào chia hết, thì n là số nguyên tố
  }

// Hàm kiểm tra một số có phải là số đối xứng (Palindrome) hay không
  bool _isPalindrome(int n) {
    String str = n.toString(); // Chuyển số thành chuỗi
    String reversedStr = str.split('').reversed.join(''); // Đảo ngược chuỗi
    return str ==
        reversedStr; // So sánh chuỗi gốc với chuỗi đảo ngược; nếu giống nhau thì là số đối xứng
  }

// Hàm tìm các biển số xe đẹp
  void findBeautifulLicensePlates() {
    if (_formKey.currentState?.validate() ?? false) {
      int a = int.tryParse(_aController.text) ??
          0; // Lấy giá trị A từ ô nhập, nếu không hợp lệ thì mặc định là 0
      int b = int.tryParse(_bController.text) ??
          0; // Lấy giá trị B từ ô nhập, nếu không hợp lệ thì mặc định là 0

      beautifulNumbers.clear(); // Xóa danh sách các số đẹp hiện tại

      for (int i = a; i <= b; i++) {
        // Duyệt qua tất cả các số từ A đến B
        if (_isPrime(i) && _isPalindrome(i)) {
          // Kiểm tra xem số i có phải là số nguyên tố và số đối xứng không
          beautifulNumbers.add(i); // Nếu có, thêm vào danh sách các số đẹp
        }
      }

      setState(() {});
    } // Cập nhật lại giao diện để hiển thị danh sách các số đẹp mới
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm biển số đẹp'),
        backgroundColor: Colors.blueAccent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _aController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Nhập số A',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.numbers),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Nhập số B',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.numbers),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: findBeautifulLicensePlates,
                    // ignore: sort_child_properties_last
                    child: const Text('Tìm biển số đẹp'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (beautifulNumbers.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '(Có ${beautifulNumbers.length} biển số đẹp) (ListView) có thể kéo trái phải để xóa',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final number = beautifulNumbers[index];
                  return Dismissible(
                    key: ValueKey<int>(number),
                    onDismissed: (direction) {
                      setState(() {
                        beautifulNumbers.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(number.toString()),
                    ),
                  );
                },
                childCount: beautifulNumbers.length,
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Danh sách biển số đẹp (GridView) có thể kéo trái phải để xóa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final number = beautifulNumbers[index];
                  return Dismissible(
                    key: ValueKey<int>(number),
                    onDismissed: (direction) {
                      setState(() {
                        beautifulNumbers.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.red),
                    child: Card(
                      child: Center(
                        child: Text(number.toString(),
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  );
                },
                childCount: beautifulNumbers.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
