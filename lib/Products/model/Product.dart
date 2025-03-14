class Product {
  int? sno;
  String? partNo;
  String? barcode;
  String productName;
  String? rack;
  String? groupName;
  String company;
  String commodity;
  String salesVat;
  String section;
  double cPrice;
  double pPrice;
  double margin;
  double mrp;
  double sPrice;
  double? splPrice;
  String unit;
  double weight;
  int expiryDays;
  String godownTax;
  String? supplier;
  double discound;
  Product(
      {required this.sno,
      required this.partNo,
      required this.barcode,
      required this.productName,
      required this.rack,
      required this.groupName,
      required this.company,
      required this.commodity,
      required this.salesVat,
      required this.section,
      required this.cPrice,
      required this.pPrice,
      required this.margin,
      required this.mrp,
      required this.sPrice,
      required this.splPrice,
      required this.unit,
      required this.weight,
      required this.expiryDays,
      required this.godownTax,
      required this.supplier,
      required this.discound});

  Product copyWith(
      {int? sno,
      String? partNo,
      String? barcode,
      String? productName,
      String? rack,
      String? groupName,
      String? company,
      String? commodity,
      String? salesVat,
      String? section,
      double? cPrice,
      double? margin,
      double? mrp,
      double? sPrice,
      double? splPrice,
      String? unit,
      double? weight,
      int? expiryDays,
      String? godownTax,
      String? supplier,
      double? discound,
      double? pPrice}) {
    return Product(
        sno: sno ?? this.sno,
        partNo: partNo ?? this.partNo,
        barcode: barcode ?? this.barcode,
        productName: productName ?? this.productName,
        rack: rack ?? this.rack,
        groupName: groupName ?? this.groupName,
        company: company ?? this.company,
        commodity: commodity ?? this.commodity,
        salesVat: salesVat ?? this.salesVat,
        section: section ?? this.section,
        cPrice: cPrice ?? this.cPrice,
        margin: margin ?? this.margin,
        mrp: mrp ?? this.mrp,
        sPrice: sPrice ?? this.sPrice,
        splPrice: splPrice ?? this.splPrice,
        unit: unit ?? this.unit,
        weight: weight ?? this.weight,
        expiryDays: expiryDays ?? this.expiryDays,
        godownTax: godownTax ?? this.godownTax,
        supplier: supplier ?? this.supplier,
        discound: discound ?? this.discound,
        pPrice: pPrice ?? this.pPrice);
  }

  @override
  String toString() {
    return 'NewProduct(sno: $sno, partNo: $partNo, barcode: $barcode, productName: $productName, '
        'rack: $rack, groupName: $groupName, company: $company, commodity: $commodity, '
        'salesVat: $salesVat, section: $section, cPrice: $cPrice,pPrice: $pPrice, margin: $margin, '
        'mrp: $mrp, sPrice: $sPrice, splPrice: $splPrice,Discound: $discound, unit: $unit, weight: $weight, '
        'expiryDays: $expiryDays, godownTax: $godownTax, supplier: $supplier)';
  }

  Map<String, dynamic> toMap() {
    return {
      'sno': sno,
      'partNo': partNo,
      'barcode': barcode,
      'productName': productName,
      'rack': rack,
      'groupName': groupName,
      'company': company,
      'commodity': commodity,
      'salesVat': salesVat,
      'section': section,
      'cPrice': cPrice,
      'pPrice': pPrice,
      'margin': margin,
      'mrp': mrp,
      'sPrice': sPrice,
      'splPrice': splPrice,
      'unit': unit,
      'weight': weight,
      'expiryDays': expiryDays,
      'godownTax': godownTax,
      'supplier': supplier,
      'discound': discound,
    };
  }
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      sno: map['sno'],
      partNo: map['partNo'],
      barcode: map['barcode'],
      productName: map['productName'] ?? '',
      rack: map['rack'],
      groupName: map['groupName'],
      company: map['company'] ?? '',
      commodity: map['commodity'] ?? '',
      salesVat: map['salesVat'] ?? '',
      section: map['section'] ?? '',
      cPrice: (map['cPrice'] as num).toDouble(),
      pPrice: (map['pPrice'] as num).toDouble(),
      margin: (map['margin'] as num).toDouble(),
      mrp: (map['mrp'] as num).toDouble(),
      sPrice: (map['sPrice'] as num).toDouble(),
      splPrice: (map['splPrice'] as num?)?.toDouble(),
      unit: map['unit'] ?? '',
      weight: (map['weight'] as num).toDouble(),
      expiryDays: map['expiryDays'] ?? 0,
      godownTax: map['godownTax'] ?? '',
      supplier: map['supplier'],
      discound: (map['discound'] as num).toDouble(),
    );
  }
}
