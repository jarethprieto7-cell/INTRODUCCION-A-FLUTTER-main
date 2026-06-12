/*{
  "shape_name": "rectangle",
  "propertys": {
    "width": 5.0,
    "breadth": 10.0
  }
}*/

class Property {
  double width;
  double breadth;

  Property({required this.width, required this.breadth});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      width: json['width'],
      breadth: json['breadth']
    );
  }
}

class Shape {
  String shapeName;
  Property property;

  Shape({required this.shapeName, required this.property});

  factory Shape.fromJson(Map<String, dynamic> json) {
    return Shape(
      shapeName: json['shape_name'],
      property: Property.fromJson(json['property'])
    );
  }
}