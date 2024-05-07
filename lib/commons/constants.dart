import 'package:flutter/material.dart';

import 'images.dart';

const APP_NAME = "Carea";
const isDarkModeOnPref = 'isDarkModeOnPref';

const BHSender_id = 1;
const BHReceiver_id = 2;

const inputTextStyle = TextStyle(color: Colors.grey, fontSize: 12);

const ListOfCarImg = [
  car1,
  car2,
  car3,
  car4,
  car5,
  car6,
  car7,
  car8,
  car9,
  car10,
  car11,
  car12,
  car13
];

const listOfCarPrize = [
  '\$190,000',
  '\$133,000',
  '\$185,000',
  '\$167,000',
  '\$190,000',
  '\$170,000',
  '\$155,000',
  '\$190,000',
  '\$133,000',
  '\$185,000',
  '\$167,000',
  '\$190,000',
  '\$170,000',
  '\$155,000',
  '\$190,000',
  '\$133,000',
  '\$185,000',
  '\$167,000',
  '\$190,000',
  '\$170,000',
  '\$155,000',
];

const listOfCarRating = [
  '4.5',
  '4.9',
  '4.3',
  '3.5',
  '3.9',
  '3.2',
  '2.9',
  '4.8',
  '4.5',
  '4.9',
  '4.3',
  '3.5',
  '3.9',
  '3.2',
  '2.9',
  '4.8'
];

const listOfCarDiscount = [
  '20%',
  '10%',
  '15%',
  '12%',
  '25%',
  '16%',
  '20%',
  '10%',
  '15%',
  '12%',
  '25%',
  '16%',
  '20%',
  '10%',
  '15%',
  '12%'
];

const carNames = [
  "Mercedes",
  "Tesla",
  "BMW",
  "Honda",
  "Toyota",
  "Volvo",
  "Bugatti",
  "Mercedes",
  "Tesla",
  "BMW",
  "Honda",
  "Toyata",
  "Volvo",
  "Bugatti",
  "Mercedes",
  "Tesla",
  "BMW",
  "Honda",
  "Toyata",
  "Volvo",
  "Bugatti",
  "Mercedes",
  "Tesla",
  "BMW",
  "Honda",
  "Toyata",
  "Volvo",
  "Bugatti",
];

// generate random project names (ex: reacctjs, flutter, education app)
const projectNames = [
  "ReactJS",
  "Flutter",
  "Education App",
  "E-commerce",
  "Food Delivery",
  "Healthcare",
  "Real Estate",
  "Travel",
  "Social Media",
  "Dating App",
  "Fitness",
  "Music",
  "Video Streaming",
  "News",
  "Weather",
  "Finance",
  "Chat App",
  "Gaming",
  "Job Portal",
  "Event Management",
  "CRM",
  "ERP",
  "POS",
  "Inventory",
  "Task Management",
  "To-Do App",
  "Calendar",
  "Notes",
  "Reminder",
  "Alarm",
  "Timer",
  "Stopwatch",
  "Countdown",
  "Calculator",
  "Currency Converter",
  "Unit Converter",
  "QR Code Scanner",
  "Barcode Scanner",
  "Document Scanner",
  "PDF Reader",
  "Ebook Reader",
  "Audio Player",
  "Video Player",
  "Image Editor",
  "Photo Editor",
  "Video Editor",
  "Screen Recorder",
  "Voice Recorder",
  "Call Recorder",
  "Music Player",
  "Video Calling",
  "Voice Calling",
  "Messaging",
  "Email",
  "SMS",
  "MMS",
  "Chat",
  "Social Networking",
  "Dating",
  "Matrimony",
  "Job Search",
  "Property Search",
  "Car Rental",
  "Bike Rental",
  "Car Wash",
  "Bike Wash",
  "Car Repair",
  "Bike Repair",
  "Car Service",
  "Bike Service",
  "Car Pooling",
  "Bike Pooling",
  "Taxi Booking",
  "Cab Booking",
  "Bus Booking",
  "Train Booking",
  "Flight Booking",
  "Hotel Booking"
];

const List listOfCarName = ["All", "Mercedes", "Tesla", "BMW", "Honda"];

const List listOfCarCondition = ['All', 'New', 'Used'];

const List listOfSortBy = ['Popular', 'Most Resent', 'Price High'];

const List listOfRatings = [
  '\u2b50 All',
  "\u2b50 5",
  "\u2b50 4",
  "\u2b50 3",
  "\u2b50 2"
];

const TextStyle textStyle1 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

const List listOfCarImage = [
  "assets/mercedes.png",
  "assets/tesla.png",
  "assets/bmw.png",
  "assets/honda.png",
  "assets/toyota.png",
  "assets/volvo.png",
  "assets/hyundai.png",
  "assets/more.png"
];

const List listOfCarBrandName = [
  "Mercedes",
  "Tesla",
  "BMW",
  "Honda",
  "Toyota",
  "Volvo",
  "Hyundai",
  "More"
];

const DATE_FORMAT_2 = 'd MMM, yyyy';
const DATE_FORMAT_3 = 'yyyy-MM-dd';
const DATE_FORMAT_4 = 'yyyy-MM-dd HH:mm';
const TIME_FORMAT_3 = 'HH:mm';

enum HIRE_STATUS { ready_to_hire, sent_hire_status, hired }
