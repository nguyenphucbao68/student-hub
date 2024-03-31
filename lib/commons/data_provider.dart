import 'package:carea/commons/constants.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';

List<CallingModel> callingDataList() {
  List<CallingModel> callingList = [];
  callingList.add(
    CallingModel(
      imageUrl: "assets/mercedes.png",
      userName: "Nissan Official",
      colorValue: Colors.green,
      subTitle: "Incoming | Dec 19 2022",
      icon: Icons.call_received,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/tesla.png",
      userName: "Opel Store",
      colorValue: Colors.blue,
      subTitle: "Outgoing | Jan 19 2022",
      icon: Icons.call_made,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      userName: "Tesla Motor",
      colorValue: Colors.red,
      subTitle: "Missed | Feb 19 2022",
      icon: Icons.call_missed,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      userName: "Dongfeng Store",
      colorValue: Colors.green,
      subTitle: "Incoming | Mar 19 2022",
      icon: Icons.call_received,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/toyota.png",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Outgoing | Apr 19 2022",
      icon: Icons.call_made,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/volvo.png",
      userName: "Valkswagen official",
      colorValue: Colors.red,
      subTitle: "Missed | May 19 2022",
      icon: Icons.call_missed,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/hyundai.png",
      userName: "Mercedes-Benz",
      colorValue: Colors.green,
      subTitle: "Incoming | June 19 2022",
      icon: Icons.call_received,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/more.png",
      userName: "Honda Motor",
      colorValue: Colors.blue,
      subTitle: "Outgoing | July 19 2022",
      icon: Icons.call_made,
    ),
  );
  callingList.add(
    CallingModel(
      imageUrl: "assets/volvo.png",
      userName: "BMW Store",
      colorValue: Colors.red,
      subTitle: "Missed | Aug 19 2022",
      icon: Icons.call_missed,
    ),
  );

  return callingList;
}

List<CallingModel> chatDataList() {
  List<CallingModel> chatList = [];
  chatList.add(
    CallingModel(
      imageUrl: "assets/mercedes.png",
      arriveTime: "09.10",
      countNumber: "2",
      userName: "Nissan Official",
      colorValue: Colors.blue,
      subTitle: "Hello welcome to BMW",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/tesla.png",
      arriveTime: "10.45",
      countNumber: "4",
      userName: "Opel Store",
      colorValue: Colors.green,
      subTitle: "I just completed it",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "12.20",
      countNumber: "6",
      userName: "Tesla Motor",
      colorValue: Colors.blue,
      subTitle: "omg, that is amazing",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      arriveTime: "04.05",
      countNumber: "",
      userName: "Dongfeng Store",
      colorValue: Colors.green,
      subTitle: "Wow, this is really fast",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      arriveTime: "06.30",
      countNumber: "8",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Just idea for next time",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      arriveTime: "08.15",
      countNumber: "",
      userName: "Valkswagen official",
      colorValue: Colors.green,
      subTitle: "I m really like driving",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      arriveTime: "10.20",
      countNumber: "4",
      userName: "Mercedes-Benz",
      colorValue: Colors.blue,
      subTitle: "perfect",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/more.png",
      arriveTime: "12.35",
      countNumber: "",
      userName: "Honda Motor",
      colorValue: Colors.green,
      subTitle: "I just completed it",
    ),
  );
  chatList.add(
    CallingModel(
      imageUrl: "assets/honda.png",
      arriveTime: "09.10",
      countNumber: "8",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Just idea for next time",
    ),
  );

  return chatList;
}

List<CallingModel> walletDataList() {
  List<CallingModel> walletList = [];
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Order",
      countNumber: "\$187.256",
      userName: "Nissan Official",
      colorValue: Colors.blue,
      subTitle: "Incoming | Dec 19 2022",
      icon: Icons.call_received,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Top up",
      countNumber: "\$250.150",
      userName: "Opel Store",
      colorValue: Colors.green,
      subTitle: "Outgoing | Jan 19 2022",
      icon: Icons.call_made,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "order",
      countNumber: "\$300.100",
      userName: "Tesla Motor",
      colorValue: Colors.red,
      subTitle: "Missed | Feb 19 2022",
      icon: Icons.call_missed,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Top up",
      countNumber: "\$500.250",
      userName: "Dongfeng Store",
      colorValue: Colors.green,
      subTitle: "Incoming | Mar 19 2022",
      icon: Icons.call_received,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Order",
      countNumber: "\$600.150",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Outgoing | Apr 19 2022",
      icon: Icons.call_made,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Top up",
      countNumber: "\$600.200",
      userName: "Valkswagen official",
      colorValue: Colors.red,
      subTitle: "Missed | May 19 2022",
      icon: Icons.call_missed,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Order",
      countNumber: "\$187.300",
      userName: "Mercedes-Benz",
      colorValue: Colors.blue,
      subTitle: "Incoming | June 19 2022",
      icon: Icons.call_received,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Top up",
      countNumber: "\200.400",
      userName: "Honda Motor",
      colorValue: Colors.green,
      subTitle: "Outgoing | July 19 2022",
      icon: Icons.call_made,
    ),
  );
  walletList.add(
    CallingModel(
      imageUrl: "assets/bmw.png",
      arriveTime: "Order",
      countNumber: "\210.600",
      userName: "BMW Store",
      colorValue: Colors.red,
      subTitle: "Missed | Aug 19 2022",
      icon: Icons.call_missed,
    ),
  );

  return walletList;
}

List<CallingModel> activeDataList() {
  List<CallingModel> activeList = [];
  activeList.add(
    CallingModel(
      imageUrl: "assets/car1.png",
      countNumber: "\$187.256",
      userName: "Nissan Official",
      colorValue: Colors.blue,
      subTitle: "Blue",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car2.png",
      countNumber: "\$250.150",
      userName: "Opel Store",
      colorValue: Colors.green,
      subTitle: "Green",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car3.png",
      countNumber: "\$300.100",
      userName: "Tesla Motor",
      colorValue: Colors.yellow,
      subTitle: "Yellow",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car4.png",
      countNumber: "\$500.250",
      userName: "Dongfeng Store",
      colorValue: Colors.red,
      subTitle: "Red",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car5.png",
      countNumber: "\$600.150",
      userName: "BMW Store",
      colorValue: Colors.blueAccent,
      subTitle: "BlueAccent",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car6.png",
      countNumber: "\$600.200",
      userName: "Valkswagen official",
      colorValue: Colors.greenAccent,
      subTitle: "GreenAccent",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car7.png",
      countNumber: "\$187.300",
      userName: "Mercedes-Benz",
      colorValue: Colors.purple,
      subTitle: "Purple",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car8.png",
      countNumber: "\200.400",
      userName: "Honda Motor",
      colorValue: Colors.pink,
      subTitle: "Pink",
    ),
  );
  activeList.add(
    CallingModel(
      imageUrl: "assets/car9.png",
      countNumber: "\210.600",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Blue",
    ),
  );

  return activeList;
}

List<CallingModel> projectDataList() {
  List<CallingModel> projectList = [];
  projectList.add(
    CallingModel(
      imageUrl: "assets/car1.png",
      countNumber: "\$187.256",
      userName: "Nissan Official",
      colorValue: Colors.blue,
      subTitle: "Blue",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car2.png",
      countNumber: "\$250.150",
      userName: "Opel Store",
      colorValue: Colors.green,
      subTitle: "Green",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car3.png",
      countNumber: "\$300.100",
      userName: "Tesla Motor",
      colorValue: Colors.yellow,
      subTitle: "Yellow",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car4.png",
      countNumber: "\$500.250",
      userName: "Dongfeng Store",
      colorValue: Colors.red,
      subTitle: "Red",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car5.png",
      countNumber: "\$600.150",
      userName: "BMW Store",
      colorValue: Colors.blueAccent,
      subTitle: "BlueAccent",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car6.png",
      countNumber: "\$600.200",
      userName: "Valkswagen official",
      colorValue: Colors.greenAccent,
      subTitle: "GreenAccent",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car7.png",
      countNumber: "\$187.300",
      userName: "Mercedes-Benz",
      colorValue: Colors.purple,
      subTitle: "Purple",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car8.png",
      countNumber: "\200.400",
      userName: "Honda Motor",
      colorValue: Colors.pink,
      subTitle: "Pink",
    ),
  );
  projectList.add(
    CallingModel(
      imageUrl: "assets/car9.png",
      countNumber: "\210.600",
      userName: "BMW Store",
      colorValue: Colors.blue,
      subTitle: "Blue",
    ),
  );

  return projectList;
}

List<BHMessageModel> getChatMsgData() {
  List<BHMessageModel> list = [];

  BHMessageModel c1 = BHMessageModel();
  c1.senderId = BHSender_id;
  c1.receiverId = BHReceiver_id;
  c1.msg = 'Helloo';
  c1.time = '1:49 AM';
  list.add(c1);

  BHMessageModel c2 = BHMessageModel();
  c2.senderId = BHSender_id;
  c2.receiverId = BHReceiver_id;
  c2.msg = 'How are you? What are you doing?';
  c2.time = '1:48 AM';
  list.add(c2);

  BHMessageModel c3 = BHMessageModel();
  c3.senderId = BHReceiver_id;
  c3.receiverId = BHSender_id;
  c3.msg = 'Helloo...';
  c3.time = '1:46 AM';
  list.add(c3);

  BHMessageModel c4 = BHMessageModel();
  c4.senderId = BHSender_id;
  c4.receiverId = BHReceiver_id;
  c4.msg = 'I am good. Can you do something for me? I need your help.';
  c4.time = '1:45 AM';
  list.add(c4);

  return list;
}

List<CallingModel> carBrandList() {
  List<CallingModel> carBrandData = [];
  carBrandData.add(CallingModel(userName: "All", selectCarCategory: false));
  carBrandData
      .add(CallingModel(userName: "Mercedes", selectCarCategory: false));
  carBrandData.add(CallingModel(userName: "Tesla", selectCarCategory: false));
  carBrandData.add(CallingModel(userName: "BMW", selectCarCategory: false));
  carBrandData.add(CallingModel(userName: "Honda", selectCarCategory: false));

  return carBrandData;
}

List<CallingModel> carConditionList() {
  List<CallingModel> carConditionData = [];
  carConditionData.add(CallingModel(userName: "All", selectCarCategory: false));
  carConditionData.add(CallingModel(userName: "New", selectCarCategory: false));
  carConditionData
      .add(CallingModel(userName: "Used", selectCarCategory: false));

  return carConditionData;
}

List<CallingModel> carRattingList() {
  List<CallingModel> carRattingData = [];
  carRattingData.add(CallingModel(userName: "All", selectCarCategory: false));
  carRattingData.add(CallingModel(userName: "5", selectCarCategory: false));
  carRattingData.add(CallingModel(userName: "4", selectCarCategory: false));
  carRattingData.add(CallingModel(userName: "3", selectCarCategory: false));
  carRattingData.add(CallingModel(userName: "2", selectCarCategory: false));

  return carRattingData;
}
