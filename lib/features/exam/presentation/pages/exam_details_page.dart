import 'package:exams/core/theme/image_app.dart';
import 'package:exams/core/theme/theme_app.dart';
import 'package:exams/core/widgets/app_elevated_button.dart';
import 'package:exams/features/exam/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_paths.dart';

class ExamDetailsPage extends StatelessWidget {
  const ExamDetailsPage({super.key, required this.exam});

  final ExamEntity exam;
  final List<String> _instructions = const [
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.colors.whiteColor,
      appBar: AppBar(
        backgroundColor: ThemeApp.colors.whiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImageApp.profit,
                    width: 42.w,
                    height: 47.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Container(
                        width: 42.w,
                        height: 47.h,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            exam.title,
                            style: ThemeApp.text.medium20black,
                          ),
                        ),
                        Text(
                          '${exam.duration} Minutes',
                          style: ThemeApp.text.regular13blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text('High level', style: ThemeApp.text.medium18black),
                  SizedBox(width: 10.w),
                  Container(
                    width: 1,
                    height: 18.h,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '${exam.numberOfQuestions} Questions',
                    style: ThemeApp.text.regular14gray,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Divider(color: Colors.grey.shade300, height: 1),
              SizedBox(height: 24.h),
              Text(
                'Instructions',
                style: ThemeApp.text.medium18black,
              ),
              SizedBox(height: 20.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _instructions.length,
                separatorBuilder: (_, _) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          _instructions[index],
                          style: ThemeApp.text.medium14gray,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 48.h),
              AppElevatedButton(
                text: 'Start',
                onPressed:() => context.push(RoutePaths.examSession),
              ),
            ],
          ),
        ),
      ),
    );
  }
}