import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'dart:ui';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/resources/eurekoin.dart';
import 'package:timeago/timeago.dart' as timeago;

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TextEditingController editingController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool showBottomMenu = false;
  bool search = false;
  List<dynamic> _foundUsers = [];
  bool selected = false;
  bool back = false;
  List<dynamic> _trans = [];
  @override
  void initState() {
    fetchTransactions().then((value) {
      setState(() {
        _trans = value;
        print("trans = $_trans");
      });
    });
    super.initState();
  }

  Future fetchTransactions() async {
    List<dynamic> list = await Eurekoin.transactionsHistory();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Aarohan_bg.png"), fit: BoxFit.fill),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    children: [
                      topBar(
                        pageName: "Transfer",
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.2.w),
                              borderRadius: BorderRadius.circular(15.sp),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Transfer Eurekoins",
                                  style: TextStyle(
                                      letterSpacing: 0.5,
                                      fontFamily: 'Staat',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: fromCssColor("#CECECE")
                                                .withOpacity(0.4),
                                            border: Border.all(
                                                color: Colors.red,
                                                width: 0.5.sp),
                                            borderRadius:
                                                BorderRadius.circular(10.sp)),
                                        child: Padding(
                                          padding: EdgeInsets.all(1.sp),
                                          child: TextField(
                                            onTap: () {
                                              setState(() {
                                                selected = false;
                                              });
                                            },
                                            onChanged: (value) async {
                                              _foundUsers =
                                                  await Eurekoin.getAllUsers(
                                                      editingController.text);
                                              setState(() {
                                                search = true;
                                              });
                                            },
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13.sp,
                                                letterSpacing: 0.1),
                                            controller: editingController,
                                            decoration: InputDecoration(
                                                icon: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.w),
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        2.w, 1.h, 2.w, 1.h),
                                                border: InputBorder.none,
                                                hintText:
                                                    'Search User to Transfer',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            //
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Visibility(
                                  visible: (!selected && search) &&
                                      (editingController.text != ""),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 1.w),
                                    child: Container(
                                      // height: 30.h,
                                      child: (_foundUsers != null &&
                                              _foundUsers.isNotEmpty)
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _foundUsers.length,
                                              itemBuilder: (context, index) =>
                                                  ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 1.5, sigmaY: 1.5),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            1.w, 1.h, 1.w, 1.h),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          editingController
                                                                  .text =
                                                              _foundUsers[index]
                                                                  [1];
                                                          selected = !selected;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.blue,
                                                                width: 0.2.w),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.sp),
                                                            color: fromCssColor(
                                                                    '#E2F5FF')
                                                                .withOpacity(
                                                                    0.3)),
                                                        child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        1.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  height: 35.sp,
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: Image.network(
                                                                          _foundUsers[index]
                                                                              [
                                                                              2])),
                                                                ),
                                                                Text(
                                                                  _foundUsers[
                                                                      index][0],
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12.sp,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20.sp,
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 1.h, 4.w, 1.h),
                                              child: Container(
                                                height: 8.h,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 0.2.w),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.sp),
                                                    color:
                                                        fromCssColor('#E2F5FF')
                                                            .withOpacity(0.25)),
                                                child: Center(
                                                  child: Text(
                                                    'No results found',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Mons',
                                                        letterSpacing: 1.1,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: fromCssColor('#CECECE')
                                              .withOpacity(0.4),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 0.5.sp),
                                          borderRadius:
                                              BorderRadius.circular(7.sp)),
                                      width: 35.w,
                                      child: TextField(
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.sp,
                                            letterSpacing: 1),
                                        controller: amountController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                2.w, 5, 1.w, 5),
                                            border: InputBorder.none,
                                            hintText: 'Amount',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500)),
                                        //
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        int status =
                                            await Eurekoin.transferEurekoin(
                                                amountController.text,
                                                editingController.text);
                                        if (status == 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Transaction Successful!")));
                                        } else if (status == 3) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Insufficient Balance!")));
                                        } else if (status == 4) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Invalid Amount!")));
                                        } else if (status == 5) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Sender cannot be the receiver!")));
                                        }
                                        amountController.clear();
                                        editingController.clear();
                                        await fetchTransactions().then((value) {
                                          setState(() {
                                            _trans = value;
                                          });
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5.sp),
                                            borderRadius:
                                                BorderRadius.circular(5.sp)),
                                        child: Text(
                                          "SEND",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Recent Transactions",
                                  style: TextStyle(
                                      letterSpacing: 0.5,
                                      fontFamily: 'Staat',
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  height: 25.h,
                                  child: (_trans.length != 0)
                                      ? ListView.builder(
                                          itemCount: _trans.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  3.w, 1.h, 3.w, 1.h),
                                              child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      3.w, 1.h, 3.w, 0.h),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 0.2.w),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.sp),
                                                      color: fromCssColor(
                                                              '#E2F5FF')
                                                          .withOpacity(0.25)),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        child: Text(
                                                          (int.parse(_trans[index]
                                                                          [0]
                                                                      .toString()) >
                                                                  0)
                                                              ? "From: ${_trans[index][1]}"
                                                              : "To: ${_trans[index][1]}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                      // SizedBox(
                                                      //   height: 0.5.h,
                                                      // ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          (int.parse(_trans[index]
                                                                          [0]
                                                                      .toString()) >
                                                                  0)
                                                              ? Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ImageIcon(
                                                                      AssetImage(
                                                                          'assets/received.png'),
                                                                      color: Colors
                                                                          .greenAccent,
                                                                    ),
                                                                    Text(
                                                                      "RECEIVED",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .greenAccent,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ImageIcon(
                                                                      AssetImage(
                                                                          'assets/sent.png'),
                                                                      color: Colors
                                                                          .redAccent,
                                                                    ),
                                                                    Text(
                                                                      "SENT",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .redAccent,
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                  'assets/Eurekoin_orange.jpg',
                                                                  height:
                                                                      height *
                                                                          0.04,
                                                                  width: width *
                                                                      0.09),
                                                              SizedBox(
                                                                  width: 1.w),
                                                              Text(
                                                                "${int.parse((_trans[index][0]).toString()).abs().toString()}",
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          "${timeago.format(DateTime.parse(_trans[index][2]).toLocal())}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
