import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  final String name = "Mike Rack";
  final String id = "STU-2025-0042";
  final String department = "Computer Science & Engineering";

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void showStudentDetails() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),

                Text("Name: $name"),
                SizedBox(height: 10.h),

                Text("ID: $id"),
                SizedBox(height: 10.h),

                Text("Dept: $department"),
                SizedBox(height: 20.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void markPresent() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$name marked as Present"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget shimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(width: 260.w, height: 320.h, child: Card()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Profile",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: isLoading
            ? shimmerLoader()
            : Container(
                width: 280.w,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.indigo.shade100,
                          child: Icon(
                            Icons.person,
                            size: 45.sp,
                            color: Colors.indigo,
                          ),
                        ),

                        Positioned(
                          right: -5,
                          top: -2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "New",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text("ID: $id", style: TextStyle(fontSize: 14.sp)),

                    SizedBox(height: 6.h),

                    Text(
                      department,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    SizedBox(height: 25.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: showStudentDetails,
                        icon: const Icon(Icons.info_outline),
                        label: const Text("View Details"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: markPresent,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text("Mark Present"),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          foregroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
