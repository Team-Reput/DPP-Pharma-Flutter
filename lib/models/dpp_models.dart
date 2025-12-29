class DppResponse {
  final bool isSuccessful;
  final String message;
  final List<DppDataItem> data;

  DppResponse({
    required this.isSuccessful,
    required this.message,
    required this.data,
  });

  factory DppResponse.fromJson(Map<String, dynamic> json) {
    return DppResponse(
      isSuccessful: json['issuccessful'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DppDataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DppDataItem {
  final bool oStatus;
  final String oMessage;
  final DppDetails oDetails;

  DppDataItem({
    required this.oStatus,
    required this.oMessage,
    required this.oDetails,
  });

  factory DppDataItem.fromJson(Map<String, dynamic> json) {
    return DppDataItem(
      oStatus: json['o_status'] as bool? ?? false,
      oMessage: json['o_message'] as String? ?? '',
      oDetails: DppDetails.fromJson(json['o_details'] as Map<String, dynamic>),
    );
  }
}

class DppDetails {
  final List<ProductDetails> productDetails;
  final List<PackagingDetails> packagingDetails;

  DppDetails({required this.productDetails, required this.packagingDetails});

  factory DppDetails.fromJson(Map<String, dynamic> json) {
    return DppDetails(
      productDetails: (json['productdetails'] as List<dynamic>? ?? [])
          .map((e) => ProductDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      packagingDetails: (json['packagingdetails'] as List<dynamic>? ?? [])
          .map((e) => PackagingDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductDetails {
  final String uses;
  final int? gstRate;
  final String gtinSku;
  final String hsnCode;
  final String? strength;
  final String brandName;
  final String skuNumber;
  final String highlights;
  final String dosageForm;
  final String expiryDate;
  final bool infantFood;
  final List<Composition> compositions;
  final String productName;
  final bool isReturnable;
  final String specification;
  final int unitsInPack;
  final String vegOrNonveg;
  final String flavourColour;
  final String originCountry;
  final bool pregnancyCare;
  final List<KeyIngredient> keyIngredients;
  final String manufactureName;
  final String productImageUrl;
  final String directionsOfUse;
  final String? productAttribute;
  final String targetPopulation;
  final String dateOfManufacture;
  final num productWeightGrams;
  final String manufacturingLocation;
  final String suggestedCategoryUdp;
  final String routeOfAdministration;
  final List<ProductCertificate> productCertificates;

  ProductDetails({
    required this.uses,
    required this.gstRate,
    required this.gtinSku,
    required this.hsnCode,
    required this.strength,
    required this.brandName,
    required this.skuNumber,
    required this.highlights,
    required this.dosageForm,
    required this.expiryDate,
    required this.infantFood,
    required this.compositions,
    required this.productName,
    required this.isReturnable,
    required this.specification,
    required this.unitsInPack,
    required this.vegOrNonveg,
    required this.flavourColour,
    required this.originCountry,
    required this.pregnancyCare,
    required this.keyIngredients,
    required this.manufactureName,
    required this.productImageUrl,
    required this.directionsOfUse,
    required this.productAttribute,
    required this.targetPopulation,
    required this.dateOfManufacture,
    required this.productWeightGrams,
    required this.manufacturingLocation,
    required this.suggestedCategoryUdp,
    required this.routeOfAdministration,
    required this.productCertificates,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      uses: json['uses'] as String? ?? '',
      gstRate: json['gst_rate'] as int?,
      gtinSku: json['gtin_sku'] as String? ?? '',
      hsnCode: json['hsn_code'] as String? ?? '',
      strength: json['strength'] as String?,
      brandName: json['brandname'] as String? ?? '',
      skuNumber: json['skunumber'] as String? ?? '',
      highlights: json['highlights'] as String? ?? '',
      dosageForm: json['dosage_form'] as String? ?? '',
      expiryDate: json['expiry_date'] as String? ?? '',
      infantFood: json['infant_food'] as bool? ?? false,
      compositions: (json['compositions'] as List<dynamic>? ?? [])
          .map((e) => Composition.fromJson(e as Map<String, dynamic>))
          .toList(),
      productName: json['product_name'] as String? ?? '',
      isReturnable: json['is_returnable'] as bool? ?? false,
      specification: json['specification'] as String? ?? '',
      unitsInPack: json['units_in_pack'] as int? ?? 0,
      vegOrNonveg: json['veg_or_nonveg'] as String? ?? '',
      flavourColour: json['flavour_colour'] as String? ?? '',
      originCountry: json['origin_country'] as String? ?? '',
      pregnancyCare: json['pregnancy_care'] as bool? ?? false,
      keyIngredients: (json['key_ingredients'] as List<dynamic>? ?? [])
          .map((e) => KeyIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      manufactureName: json['manufacturename'] as String? ?? '',
      productImageUrl: json['productimageurl'] as String? ?? '',
      directionsOfUse: json['directions_of_use'] as String? ?? '',
      productAttribute: json['product_attribute'] as String?,
      targetPopulation: json['target_population'] as String? ?? '',
      dateOfManufacture: json['date_of_manufacture'] as String? ?? '',
      productWeightGrams: json['product_weight_grams'] as num? ?? 0,
      manufacturingLocation: json['manufacturinglocation'] as String? ?? '',
      suggestedCategoryUdp: json['suggested_category_udp'] as String? ?? '',
      routeOfAdministration: json['route_of_administration'] as String? ?? '',
      productCertificates:
          (json['product_certificates'] as List<dynamic>? ?? [])
              .map(
                (e) => ProductCertificate.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

class Composition {
  final String? partUsed;
  final num? extractMg;
  final String? botanicalName;
  final num? derivedFromMg;
  final String ingredientName;
  final String? edibleColours;
  final bool? isPreservative;

  Composition({
    required this.partUsed,
    required this.extractMg,
    required this.botanicalName,
    required this.derivedFromMg,
    required this.ingredientName,
    required this.edibleColours,
    required this.isPreservative,
  });

  factory Composition.fromJson(Map<String, dynamic> json) {
    return Composition(
      partUsed: json['part_used'] as String?,
      extractMg: json['extract_mg'] as num?,
      botanicalName: json['botanical_name'] as String?,
      derivedFromMg: json['derived_from_mg'] as num?,
      ingredientName: (json['ingredient_name'] ?? '') as String,
      edibleColours: json['edible_colours'] as String?,
      isPreservative: json['ispreservative'] as bool?,
    );
  }
}

class KeyIngredient {
  final String functions;
  final String botanicalName;
  final String ingredientName;

  KeyIngredient({
    required this.functions,
    required this.botanicalName,
    required this.ingredientName,
  });

  factory KeyIngredient.fromJson(Map<String, dynamic> json) {
    return KeyIngredient(
      functions: json['functions'] as String? ?? '',
      botanicalName: json['botanical_name'] as String? ?? '',
      ingredientName: json['ingredientname'] as String? ?? '',
    );
  }
}

class PackagingDetails {
  final int tabId;
  final String tabName;
  final int packSize;
  final String skuNumber;
  final String batchNumber;
  final String productName;
  final int unitsInPack;
  final String packagingType;

  PackagingDetails({
    required this.tabId,
    required this.tabName,
    required this.packSize,
    required this.skuNumber,
    required this.batchNumber,
    required this.productName,
    required this.unitsInPack,
    required this.packagingType,
  });

  factory PackagingDetails.fromJson(Map<String, dynamic> json) {
    return PackagingDetails(
      tabId: json['tabid'] as int? ?? 0,
      tabName: json['tabname'] as String? ?? '',
      packSize: json['packsize'] as int? ?? 0,
      skuNumber: json['sku_number'] as String? ?? '',
      batchNumber: json['batch_number'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      unitsInPack: json['units_in_pack'] as int? ?? 0,
      packagingType: json['packaging_type'] as String? ?? '',
    );
  }
}

class ProductCertificate {
  final String? issueDate;
  final String documentUrl;
  final String documentName;
  final String documentType;
  final String certificateName;
  final String? lastValidityDate;

  ProductCertificate({
    required this.issueDate,
    required this.documentUrl,
    required this.documentName,
    required this.documentType,
    required this.certificateName,
    required this.lastValidityDate,
  });

  factory ProductCertificate.fromJson(Map<String, dynamic> json) {
    return ProductCertificate(
      issueDate: json['issuedate'] as String?,
      documentUrl: json['documenturl'] as String? ?? '',
      documentName: json['documentname'] as String? ?? '',
      documentType: json['document_type'] as String? ?? '',
      certificateName: json['certificatename'] as String? ?? '',
      lastValidityDate: json['last_validitydate'] as String?,
    );
  }
}
