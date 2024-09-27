import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morning_reminder/notification/notification.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 0);

  void _incrementTime() {
    setState(() {
      int newMinute = (_time.minute + 1) % 60;
      int newHour = _time.hour;
      if (newMinute == 0) {
        newHour = (_time.hour + 1) % 24;
      }
      _time = _time.replacing(hour: newHour, minute: newMinute);
    });
  }

  void _decrementTime() {
    setState(() {
      int newMinute = (_time.minute - 1 + 60) % 60;
      int newHour = _time.hour;
      if (newMinute == 59) {
        newHour = (_time.hour - 1 + 24) % 24;
      }
      _time = _time.replacing(hour: newHour, minute: newMinute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 146.h,
          ),
          AspectRatio(
            aspectRatio: 2.03,
            child: Image.asset("assets/daily_routine.png"),
          ),
          SizedBox(height: 44.h),
          Text(
            'Morning Reminder',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: Text(
              'Enter your wake up time and we will send you a reminder at the time. Learn the meaning of your dream before you forget it.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Morning Time",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementTime,
                      icon: Icon(
                        Icons.remove_circle,
                        color:const Color(0xFF54408C),
                        size: 24.sp,
                      ),
                    ),
                    Text(
                      '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementTime,
                      icon: Icon(
                        Icons.add_circle,
                        color: const Color(0xFF54408C),
                        size: 24.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 72.h),
          ElevatedButton(
            onPressed: () {
              final now = DateTime.now();
              final scheduledDate = DateTime(
                now.year,
                now.month,
                now.day,
                _time.hour,
                _time.minute,
              );
              NotificationService.scheduleNotification(
                  0,
                  "Time to wake up!",
                  "Remember to check the meaning of your dream",
                scheduledDate,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF54408C),
              minimumSize: Size(327.w, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.w),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}