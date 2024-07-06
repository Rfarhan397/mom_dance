import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValueProvider extends ChangeNotifier{
  bool _isChecked = false;
  bool _isloading = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;


  bool get isChecked => _isChecked;
  bool get isLoading => _isloading;
  get selectedDate => _selectedDate;
  get selectedTime => _selectedTime;

  ValueProvider(){
    setLoading(false);
  }

  void setChecked(bool value){
    _isChecked = value;
    notifyListeners();
  }

  void setLoading(bool value){
    _isloading = value;
    notifyListeners();
  }

  void setSelectedDate(DateTime? picked){
    _selectedDate = picked;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay? picked){
    _selectedTime = picked;
    notifyListeners();
  }


  DateTimeRange? _selectedDateRange;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  void setSelectedDateRange(DateTimeRange dateRange) {
    _selectedDateRange = dateRange;
    notifyListeners();
  }
}