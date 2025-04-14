import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
    String? ppmoo1; /// for without price per meter on order.
    String? ppmoo2; ///  for with price per meter on order.
    String? flat;
    String? gej;
    bool? isDelete;
    String? isWithGst;
    String? orderStatus;
    String? size;
    String? subOrderId;
    String? totalAmount;
    String? totalMeter;
    String? type;

    CreateOrderModel({
        this.ppmoo1,
        this.ppmoo2,
        this.flat,
        this.gej,
        this.isDelete,
        this.isWithGst,
        this.orderStatus,
        this.size,
        this.subOrderId,
        this.totalAmount,
        this.totalMeter,
        this.type,
    });

    factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
        ppmoo1: json["PPMOO1"],
        ppmoo2: json["PPMOO2"],
        flat: json["flat"],
        gej: json["gej"],
        isDelete: json["isDelete"],
        isWithGst: json["isWithGST"],
        orderStatus: json["orderStatus"],
        size: json["size"],
        subOrderId: json["subOrderId"],
        totalAmount: json["totalAmount"],
        totalMeter: json["totalMeter"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "PPMOO1": ppmoo1,
        "PPMOO2": ppmoo2,
        "flat": flat,
        "gej": gej,
        "isDelete": isDelete,
        "isWithGST": isWithGst,
        "orderStatus": orderStatus,
        "size": size,
        "subOrderId": subOrderId,
        "totalAmount": totalAmount,
        "totalMeter": totalMeter,
        "type": type,
    };
}
