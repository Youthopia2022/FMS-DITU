import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventBrief extends StatefulWidget {
  const EventBrief({Key? key}) : super(key: key);

  @override
  State<EventBrief> createState() => _EventBriefState();
}

class _EventBriefState extends State<EventBrief> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController minMemController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController maxMemController = TextEditingController();
  TextEditingController clubController = TextEditingController();
  TextEditingController feeDitController = TextEditingController();
  TextEditingController feeNonDitController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String _eventName = '';
  double _feeDit = 10;
  double _feeNonDit = 10;
  String _about = '';
  String _venue = '';
  double _date = 22;
  String _club = '';
  double _minMem = 1;
  double _maxMem = 1;
  bool? isTopEvent = false;
  DateTime _Date = DateTime.now();
  String dropdownvalue = 'Technical';
  // TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  addTaskToFirebase() async {
    var time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('events')
        .doc(time.toString())
        .set({
      'event name' : _eventName,
      'about' : _about,
      'venue' : _venue,
      'time' : _time,
      'min_member' : _minMem,
      'max_member' : _maxMem,
      'category' : dropdownvalue,
      'club' : _club,
      'isTopEvent' : isTopEvent,
      'eventFeeDIT' : _feeDit,
      'eventFeeNonDIT' : _feeNonDit,
      'date' : _date,
      'image': _image,
    });
  }


  String _time ='';
  String _image ='';
  // void _selectTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //     });
  //   }
  // }

  // List of items in our dropdown menu
  var items = [
    'Technical',
    'Cultural',
    'Debate',
    'Informal',
    'Gaming',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Entry Portal"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Event Name',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _eventName = text;
                    });
                  },
                )),

            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: aboutController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'About',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _about = text;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: venueController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Venue',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _venue = text;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: minMemController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Min. member',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _minMem = text as double;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: maxMemController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Max. member',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _maxMem = text as double;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: clubController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Club/Organizer',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _club = text;
                    });
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Catergory:  ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Top event:  ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  Checkbox(
                    value: isTopEvent,
                    onChanged: (bool? value) {
                      setState(() {
                        isTopEvent = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: feeDitController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Event fee(DIT)',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _feeDit = text as double;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: feeNonDitController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Event fee(Non-DIT)',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _feeNonDit = text as double;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _date = text as double;
                    });
                  },
                )),
            SizedBox(height: 30,),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time(format: 6:00 AM)',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _time = text;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _image = text;
                    });
                  },
                )),


            ElevatedButton(
              onPressed: (){
                //Todo: Submit event data to firebase
                addTaskToFirebase();
              },
              child: Text('Submit'),
            ),

            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
