import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code/screens/upload_receipt.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_code/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:flutter_code/http_requests.dart';


class DodajTrosak extends StatefulWidget{

  int dropdownvalue = 0;
  String _selectedDate = DateTime.now().toString();
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  _DodajTrosak createState() => _DodajTrosak();
}

class _DodajTrosak extends State<DodajTrosak>{

  HTTPRequest hr = HTTPRequest();

  @override
  Widget build(BuildContext context) {

    int _currentIndex = 1;
    TextEditingController _titleController = TextEditingController();
    TextEditingController _priceController = TextEditingController();
    TextEditingController _articlecontroller = TextEditingController();


    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

      if (args.value is PickerDateRange) {
        widget._range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        widget._selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        widget._dateCount = args.value.length.toString();
      } else {
        widget._rangeCount = args.value.length.toString();
      }

    }

    List<DropdownMenuItem<int>> categoryList = [ ];

    List categories = [
      "Putovanja",
      "Shopping",
      "Pokloni",
      "Hrana",
      "Gorivo",
      "Sport",
      "Ostalo",
      "Bijela Tehnika",
      "Higijena"
    ];

    for(int i = 0; i < categories.length; i++){
      categoryList.add(
        DropdownMenuItem(
          child: Text(categories[i]),
          value: i,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DodajTrosakCamera()));
              },
              icon: const Icon(
                Icons.photo_camera_outlined,
              ),
          )
        ],
        backgroundColor: CustomColor().mainColor,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: DropdownButtonFormField<int>(
                      value: widget.dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: categoryList,
                      onChanged: (newValue) {
                        widget.dropdownvalue = newValue!;
                        print(newValue);
                      },
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomColor().mainColor,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    width: 128,
                    child:  TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                        ),
                        hintText: "Cijena",
                        helperMaxLines: 128,
                        hintStyle: GoogleFonts.quicksand(
                          textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  hintText: "Opis kupnje",
                  helperMaxLines: 128,
                  hintStyle: GoogleFonts.quicksand(
                    textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              width: 256,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                selectionColor: CustomColor().mainColor,
                todayHighlightColor: CustomColor().mainColor,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 256,
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: TextFormField(
                    controller: _articlecontroller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                      ),
                      hintText: "Ime artikla",
                      helperMaxLines: 128,
                      hintStyle: GoogleFonts.quicksand(
                        textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  child: FloatingActionButton(
                    backgroundColor: CustomColor().mainColor,
                    heroTag: "nesto",
                    child: Icon(Icons.add_card),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor().mainColor,
        onPressed: () async {
          var date = DateTime.parse(widget._selectedDate);
          if(date.hour == 0) date = date.subtract(Duration(minutes: 1));
          print("sending receipt");
          await hr.newReceipt(_titleController.text, _titleController.text, int.parse(_priceController.text), ["tvoja mama"], time: date);
          Navigator.pop(context);
        
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.send_outlined,
        ),
      ),
    );
  }
}