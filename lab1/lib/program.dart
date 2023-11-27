void main() {
  var course = 'Flutter App Development';

  welcome(course);

  var car = Car('WW100', 'Nissan GTA');
  print(car);

  calculate(1000, 5);
  calculate(100, 7);
}

void calculate(double loanAmount, int yearDuration) {
  var interestRate = 0.0;

  if (yearDuration == 5) {
    interestRate = 2.6;
  } else if (yearDuration == 7) {
    interestRate = 3.2;
  }

  var totalAmount = loanAmount * (1 + interestRate);

  print("Interest rate $interestRate%, Total $totalAmount");
}

class Car {
  String? carNo;
  String? carModel;

  Car(this.carNo, this.carModel);

  String? getCarNo() {
    return carNo;
  }

  String? getCarModel() {
    return carModel;
  }

  void setCarNo(String newNo) {
    carNo = newNo;
  }

  void setCarModel(String newModel) {
    carModel = newModel;
  }

  @override
  String toString() {
    return 'Car No: $carNo, Model: $carModel';
  }
}

void welcome(course) {
  print('Welcome to $course course');
}
