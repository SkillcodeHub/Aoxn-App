import 'dart:async';

import 'package:axonweb/Provider/current_time_provider.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/colors.dart';
import '../../View_Model/SelectAppointDate_View_Model.dart/selectAppointmentDate_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../data/response/status.dart';

class SelectAppointmentDateScreen extends StatefulWidget {
  final dynamic selectedDocotrId;

  const SelectAppointmentDateScreen(
      {super.key, required this.selectedDocotrId});

  @override
  State<SelectAppointmentDateScreen> createState() =>
      _SelectAppointmentDateScreenState();
}

class _SelectAppointmentDateScreenState
    extends State<SelectAppointmentDateScreen> {
  late DateTime selectedDate; // TO tracking date
  String? datetime1;
  bool isLoading = false;
  bool TimeSlotes = false;
  String? selectedTimeSlote;
  String? DelayMinute;
  int? timingId;
  bool isButtonActive = false;
  UserPreferences userPreference = UserPreferences();
  late String token;

  dynamic advanceBookingFrom;
  dynamic advanceBookingTo;
  dynamic UserData;

  int? currentDateSelectedIndex; //For Horizontal Date
  int? currentDateSelectedIndex1; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //Scroll Controller for ListView
  ScrollController scrollController1 =
      ScrollController(); //Scroll Controller for ListView

  AppointmentSlotListViewmodel appointmentSlotListViewmodel =
      AppointmentSlotListViewmodel();

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    userPreference.getUserDetails().then((value) {
      setState(() {
        UserData = value!;
        advanceBookingFrom = UserData['data']['advanceBookingFrom'].toString();
        advanceBookingTo = UserData['data']['advanceBookingTo'].toString();
        selectedDate =
            DateTime.now().add(Duration(days: int.parse(advanceBookingFrom)));
        currentDateSelectedIndex =
            int.parse(advanceBookingFrom); //For Horizontal Date
        // TO tracking date
      });
      get();
    });
    super.initState();

    final currrentTimeProvider =
        Provider.of<TimeProvider>(context, listen: false);
    Timer.periodic(Duration(seconds: 1), (timer) {
      currrentTimeProvider.updateTime();
    });
  }

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ]; //List Of Months

  List<String> listOfDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ]; //List of Days

  createNewsListContainer(BuildContext context, int itemIndex) {
    String minuteInterval1 = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].minuteInterval!
        .toString();

    String date = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].fromTimeSlotLocal
        .toString();
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat3 = DateFormat('hh:mm a');
    var outputDate3 = outputFormat3.format(inputDate);

    String date1 = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].toTimeSlotLocal
        .toString();
    DateTime parseDate1 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date1);
    var inputDate1 = DateTime.parse(parseDate1.toString());
    var outputFormat13 = DateFormat('hh:mm a');
    var outputDate13 = outputFormat13.format(inputDate1);
    int capacity = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].capacity!
        .toInt();
    int count = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].count!
        .toInt();

    var total = capacity - count;
    return Column(
      children: [
        TimeSlotes ==
                    appointmentSlotListViewmodel
                        .AppointmentSlotList.data!.data![itemIndex].isBlocked &&
                total.toInt() > 0
            ? InkWell(
                onTap: () {
                  setState(() {
                    String minuteInterval1 = appointmentSlotListViewmodel
                        .AppointmentSlotList
                        .data!
                        .data![itemIndex]
                        .minuteInterval!
                        .toString();

                    var parts = minuteInterval1.split('.');
                    var prefix = parts[0].trim();
                    DelayMinute = prefix.toString();
                    currentDateSelectedIndex1 = itemIndex;
                    selectedTimeSlote = outputDate3 + ' - ' + outputDate13;
                    timingId = appointmentSlotListViewmodel
                        .AppointmentSlotList.data!.data![itemIndex].timingId!
                        .toInt();
                    isButtonActive = true;
                  });
                },
                child: Container(
                  height: 12.h,
                  width: 95.w,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(3, 3),
                            blurRadius: 5)
                      ],
                      color: currentDateSelectedIndex1 == itemIndex
                          ? Colors.orange.shade100
                          : Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        outputDate3 + ' - ' + outputDate13,
                        style: SizerUtil.deviceType == DeviceType.mobile
                            ? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: subTitleFontSize)
                            : TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  total / capacity > 0.7
                                      ? total.toString() + " - Available"
                                      : total / capacity > 0.4
                                          ? total.toString() + " - Filling fast"
                                          : total / capacity > 0.2
                                              ? total.toString() +
                                                  " - Filling fast"
                                              : total.toString() +
                                                  " - Filling fast",
                                  style:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: subTitleFontSize)
                                          : TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.sp),
                                ),
                                SizedBox(height: 1.h),
                                Container(
                                  height: 3,
                                  width: 80.w,
                                  child: LinearProgressIndicator(
                                    value: total / capacity,
                                    backgroundColor: total / capacity > 0.7
                                        ? Colors.green.shade200
                                        : total / capacity > 0.4
                                            ? Colors.orange.shade200
                                            : total / capacity > 0.2
                                                ? Colors
                                                    .deepOrangeAccent.shade100
                                                : Colors.red.shade200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      total / capacity > 0.7
                                          ? Colors.green
                                          : total / capacity > 0.4
                                              ? Colors.orange
                                              : total / capacity > 0.2
                                                  ? Colors.deepOrangeAccent
                                                  : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.turned_in_rounded,
                              color: currentDateSelectedIndex1 == itemIndex
                                  ? Color(0xFFFD5722)
                                  : Colors.grey.shade300,
                              size: 3.h,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 12.h,
                width: 95.w,
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    )
                  ],
                  color: Colors.grey.shade300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      outputDate3 + ' - ' + outputDate13,
                      style: SizerUtil.deviceType == DeviceType.mobile
                          ? TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: subTitleFontSize,
                              color: Colors.grey.shade700)
                          : TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp,
                              color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "0 - Not available",
                                style: SizerUtil.deviceType == DeviceType.mobile
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: subTitleFontSize)
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8.sp),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                height: 3,
                                width: 80.w,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        SizedBox(
          height: 15,
        ),
        isLoading ? Container() : Container(),
      ],
    );
  }

  get() {
    datetime1 = DateFormat("yyyy-MM-dd").format(selectedDate);
    Timer(Duration(microseconds: 20), () {
      appointmentSlotListViewmodel.fetchAppointmentSlotListApi(
          widget.selectedDocotrId.toString(),
          datetime1.toString(),
          token.toString());
    });
    isButtonActive = false;
    currentDateSelectedIndex1 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: SizerUtil.deviceType == DeviceType.mobile
              ? EdgeInsets.only(top: 12)
              : EdgeInsets.all(0),
          child: IconButton(
            iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        title: SizerUtil.deviceType == DeviceType.mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 15)
                      : SizedBox(height: 3.74.h),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? Text(
                          'Choose Time',
                          style: TextStyle(
                              fontSize: titleFontSize, color: Colors.black),
                        )
                      : Text(
                          'Choose Time',
                          style:
                              TextStyle(fontSize: 3.5.sp, color: Colors.black),
                        ),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? Consumer<TimeProvider>(
                          builder: (context, value, child) {
                          return Text(
                            '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                                ', ' +
                                "${value.currentTime.toString()} IST ",
                            style: TextStyle(
                                fontSize: subTitleFontSize,
                                color: Colors.black),
                          );
                        })
                      : Consumer<TimeProvider>(
                          builder: (context, value, child) {
                          return Text(
                            '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                                ', ' +
                                "${value.currentTime.toString()} IST ",
                            style:
                                TextStyle(fontSize: 3.sp, color: Colors.black),
                          );
                        }),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 10)
                      : SizedBox(height: 2.5.h),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 15)
                      : SizedBox(height: 3.74.h),
                  Text(
                    'Choose Time',
                    style: TextStyle(fontSize: 8.sp, color: Colors.black),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Consumer<TimeProvider>(builder: (context, value, child) {
                    return Text(
                      '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                          ', ' +
                          "${value.currentTime.toString()} IST ",
                      style: TextStyle(fontSize: 8.sp, color: Colors.black),
                    );
                  }),
                ],
              ),
      ),
      body: advanceBookingTo != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                advanceBookingFrom == '0' && advanceBookingTo == '0'
                    ? Container(
                        height: 10.h,
                        child: Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 0);
                            },
                            itemCount:
                                5, // Fixed itemCount to show 5 containers
                            controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              // Calculate the actual index considering the offset
                              int actualIndex = index + DateTime.now().day - 2;

                              // Determine if the current container represents today's date
                              bool isToday = index == 2;

                              // Determine if the current container represents the previous or upcoming dates
                              bool isDisabled = index < 2 || index > 2;

                              // Set the selected date to today's date
                              if (isToday) {
                                currentDateSelectedIndex = actualIndex;
                                selectedDate = DateTime.now();
                                datetime1 = DateFormat("yyyy-MM-dd")
                                    .format(selectedDate);
                              }

                              return InkWell(
                                onTap: isDisabled
                                    ? null // Disable onTap for previous and upcoming dates
                                    : () {
                                        setState(() {
                                          // Set the selected index only if it's today's date
                                          if (isToday) {
                                            currentDateSelectedIndex =
                                                actualIndex;
                                            selectedDate = DateTime.now();
                                            datetime1 = DateFormat("yyyy-MM-dd")
                                                .format(selectedDate);
                                            get();
                                          }
                                        });
                                      },
                                child: Container(
                                  height: 10.h,
                                  width: 20.3.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDisabled
                                        ? Colors
                                            .white // Change color for previous and upcoming dates
                                        : isToday
                                            ? Color(
                                                0xFFFD5722) // Change color for today's date
                                            : Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isToday
                                            ? "Today"
                                            : listOfDays[DateTime.now()
                                                            .add(Duration(
                                                                days:
                                                                    index - 2))
                                                            .weekday -
                                                        1]
                                                    .toString() +
                                                " - " +
                                                listOfMonths[DateTime.now()
                                                            .add(Duration(
                                                                days:
                                                                    index - 2))
                                                            .month -
                                                        1]
                                                    .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 8.sp
                                              : 8.sp,
                                          color: isDisabled
                                              ? Colors.grey
                                              : isToday
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        isToday
                                            ? DateTime.now().day.toString()
                                            : DateTime.now()
                                                .add(Duration(days: index - 2))
                                                .day
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 17.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDisabled
                                              ? Colors.grey
                                              : isToday
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: 10.h,
                        child: Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 0);
                            },
                            itemCount: int.parse(advanceBookingTo) +
                                1 -
                                int.parse(advanceBookingFrom) +
                                4,
                            controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              // Calculate the actual index considering the offset
                              int actualIndex =
                                  index + int.parse(advanceBookingFrom) - 2;

                              // Determine if it's within the range of the first two and last two elements
                              bool isDisabled = index < 2 ||
                                  index >=
                                      int.parse(advanceBookingTo) +
                                          1 -
                                          int.parse(advanceBookingFrom) +
                                          2;

                              // Determine the text color based on container state
                              Color textColor;
                              if (isDisabled) {
                                textColor = Colors.grey;
                              } else if (currentDateSelectedIndex ==
                                  actualIndex) {
                                textColor = Colors.white;
                              } else {
                                textColor = Colors.black;
                              }

                              return InkWell(
                                onTap: isDisabled
                                    ? null // Disable onTap for first two and last two containers
                                    : () {
                                        setState(() {
                                          // Set the selected index only if it's not disabled
                                          currentDateSelectedIndex =
                                              actualIndex;
                                          selectedDate = DateTime.now()
                                              .add(Duration(days: actualIndex));
                                          datetime1 = DateFormat("yyyy-MM-dd")
                                              .format(selectedDate);
                                          get();
                                        });
                                      },
                                child: Container(
                                  height: 10.h,
                                  width: 20.3.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDisabled
                                        ? Colors
                                            .white // Change color for disabled containers
                                        : currentDateSelectedIndex ==
                                                actualIndex
                                            ? Color(0xFFFD5722)
                                            : Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listOfDays[DateTime.now()
                                                        .add(Duration(
                                                            days: actualIndex))
                                                        .weekday -
                                                    1]
                                                .toString() +
                                            " - " +
                                            listOfMonths[DateTime.now()
                                                        .add(Duration(
                                                            days: actualIndex))
                                                        .month -
                                                    1]
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 9.sp
                                              : 8.sp,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        DateTime.now()
                                            .add(Duration(days: actualIndex))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 17.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: ChangeNotifierProvider<AppointmentSlotListViewmodel>(
                      create: (BuildContext context) =>
                          appointmentSlotListViewmodel,
                      child: Consumer<AppointmentSlotListViewmodel>(
                        builder: (context, value, _) {
                          switch (value.AppointmentSlotList.status!) {
                            case Status.LOADING:
                              return Center(
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.AppointmentSlotList.message
                                      .toString()));
                            case Status.COMPLETED:
                              return SizedBox(
                                height: 73.h,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 10),
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: appointmentSlotListViewmodel
                                        .AppointmentSlotList.data!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int itemIndex) {
                                      return createNewsListContainer(
                                          context, itemIndex);
                                    }),
                              );
                          }
                        },
                      )),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isButtonActive ? Colors.green : Colors.grey,
        onPressed: isButtonActive
            ? () => Navigator.pop(context, [
                  datetime1,
                  selectedTimeSlote,
                  timingId.toString(),
                  DelayMinute!.toString(),
                ])
            : null,
        child: Icon(Icons.check),
      ),
    );
  }
}
