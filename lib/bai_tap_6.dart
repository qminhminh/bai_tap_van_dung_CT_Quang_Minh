// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
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

  // Hàm kiểm tra số nguyên tố
  bool _isPrime(int n) {
    // Nếu số nhỏ hơn 2, không phải là số nguyên tố
    if (n < 2) return false;

    // Kiểm tra tính chia hết của số từ 2 đến căn bậc hai của n
    for (int i = 2; i * i <= n; i++) {
      // Nếu n chia hết cho i, thì n không phải là số nguyên tố
      if (n % i == 0) return false;
    }

    // Nếu không tìm thấy số nào chia hết, thì n là số nguyên tố
    return true;
  }

// Hàm kiểm tra số đối xứng (palindrome)
  bool _isPalindrome(int n) {
    // Chuyển số thành chuỗi
    String str = n.toString();

    // Đảo ngược chuỗi
    String reversedStr = str.split('').reversed.join('');

    // So sánh chuỗi gốc với chuỗi đảo ngược
    // Nếu giống nhau, thì số là số đối xứng
    return str == reversedStr;
  }

// Hàm tìm các số biển số đẹp
  void findBeautifulLicensePlates() {
    // Kiểm tra tính hợp lệ của các trường nhập liệu
    if (_formKey.currentState?.validate() ?? false) {
      // Lấy giá trị A từ ô nhập, nếu không hợp lệ thì mặc định là 0
      int a = int.tryParse(_aController.text) ?? 0;

      // Lấy giá trị B từ ô nhập, nếu không hợp lệ thì mặc định là 0
      int b = int.tryParse(_bController.text) ?? 0;

      // Xóa danh sách các số đẹp hiện tại
      beautifulNumbers.clear();

      // Duyệt qua tất cả các số từ A đến B
      for (int i = a; i <= b; i++) {
        // Kiểm tra xem số i có phải là số nguyên tố và số đối xứng không
        if (_isPrime(i) && _isPalindrome(i)) {
          // Nếu có, thêm vào danh sách các số đẹp
          beautifulNumbers.add(i);
        }
      }

      // Cập nhật lại giao diện để hiển thị danh sách các số đẹp mới
      setState(() {});
    }
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: findBeautifulLicensePlates,
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
                          child: Text('Tìm biển số đẹp'),
                        ),
                      ],
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
                  '(Có ${beautifulNumbers.length} biển số đẹp) (Sliver ListView) có thể kéo trái phải để xóa',
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
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Danh sách biển số đẹp (Sliver GridView) có thể kéo trái phải để xóa',
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
            // Sliver ListView.builder
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Danh sách biển số đẹp (Listview buidler) có thể kéo trái phải để xóa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200, // Set height for the ListView
                child: ListView.builder(
                  cacheExtent:
                      200.0, // Dự trữ khoảng cách cache trước khi render
                  addAutomaticKeepAlives:
                      true, // Tự động giữ alive các widget trong gridview
                  addRepaintBoundaries:
                      true, // Tự động tối ưu hóa repaint boundaries
                  addSemanticIndexes:
                      true, // Thêm semantic index cho các mục (hữu ích cho accessibility)
                  dragStartBehavior:
                      DragStartBehavior.start, // Hành vi bắt đầu kéo
                  clipBehavior: Clip
                      .hardEdge, // Điều khiển clip nội dung khi vượt khỏi vùng hiển thị
                  scrollDirection: Axis.vertical,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                      .onDrag, // Ẩn bàn phím khi cuộn
                  shrinkWrap: true, // Kích thước lưới sẽ thu nhỏ theo nội dung
                  controller: ScrollController(),
                  primary:
                      false, // Nếu true, lưới sẽ tự động được xem là chính (main scroll)
                  reverse: false, // Không cuộn ngược
                  itemCount: beautifulNumbers.length,
                  itemBuilder: (context, index) {
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
                ),
              ),
            ),
            // Sliver GridView.builder
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Danh sách biển số đẹp (GridView buidler) có thể kéo trái phải để xóa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 300, // Set height for the GridView
                child: GridView.builder(
                  cacheExtent:
                      200.0, // Dự trữ khoảng cách cache trước khi render
                  addAutomaticKeepAlives:
                      true, // Tự động giữ alive các widget trong gridview
                  addRepaintBoundaries:
                      true, // Tự động tối ưu hóa repaint boundaries
                  addSemanticIndexes:
                      true, // Thêm semantic index cho các mục (hữu ích cho accessibility)
                  dragStartBehavior:
                      DragStartBehavior.start, // Hành vi bắt đầu kéo
                  clipBehavior: Clip
                      .hardEdge, // Điều khiển clip nội dung khi vượt khỏi vùng hiển thị
                  scrollDirection: Axis.vertical,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                      .onDrag, // Ẩn bàn phím khi cuộn
                  shrinkWrap: true, // Kích thước lưới sẽ thu nhỏ theo nội dung
                  controller: ScrollController(),
                  primary:
                      false, // Nếu true, lưới sẽ tự động được xem là chính (main scroll)
                  reverse: false, // Không cuộn ngược
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: beautifulNumbers.length,
                  itemBuilder: (context, index) {
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
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
