class AppointmentErrorResponseModel {
    AppointmentErrorResponseModel({
        this.meta,
        this.data,
    });

    AppointmentErrorMetaModel? meta;
    AppointmentErrorDataModel? data;

    factory AppointmentErrorResponseModel.fromJson(Map<String, dynamic> json) => AppointmentErrorResponseModel(
        meta: AppointmentErrorMetaModel.fromJson(json["meta"]),
        data: AppointmentErrorDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
    };
}

class AppointmentErrorDataModel {
    AppointmentErrorDataModel({
        this.message,
    });

    String? message;

    factory AppointmentErrorDataModel.fromJson(Map<String, dynamic> json) => AppointmentErrorDataModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

class AppointmentErrorMetaModel {
    AppointmentErrorMetaModel({
        this.code,
        this.status,
        this.message,
    });

    int? code;
    String? status;
    String? message;

    factory AppointmentErrorMetaModel.fromJson(Map<String, dynamic> json) => AppointmentErrorMetaModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
    };
}
