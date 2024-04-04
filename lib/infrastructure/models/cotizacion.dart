

class Cotizaciones {
    final int idCotizacion;
    final int idCliente;
    final String estado;
    final bool activo;
    final dynamic total;
    final IdClienteNavigation idClienteNavigation;
    final List<CotizacionProducto> cotizacionProducto;
    final List<DetalleCotizacion> detalleCotizacion;

    Cotizaciones({
        required this.idCotizacion,
        required this.idCliente,
        required this.estado,
        required this.activo,
        required this.total,
        required this.idClienteNavigation,
        required this.cotizacionProducto,
        required this.detalleCotizacion,
    });

    factory Cotizaciones.fromJson(Map<String, dynamic> json) => Cotizaciones(
        idCotizacion: json["idCotizacion"],
        idCliente: json["idCliente"],
        estado: json["estado"],
        activo: json["activo"],
        total: json["total"],
        idClienteNavigation: IdClienteNavigation.fromJson(json["idClienteNavigation"]),
        cotizacionProducto: List<CotizacionProducto>.from(json["cotizacionProducto"].map((x) => CotizacionProducto.fromJson(x))),
        detalleCotizacion: List<DetalleCotizacion>.from(json["detalleCotizacion"].map((x) => DetalleCotizacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idCotizacion": idCotizacion,
        "idCliente": idCliente,
        "estado": estado,
        "activo": activo,
        "total": total,
        "idClienteNavigation": idClienteNavigation.toJson(),
        "cotizacionProducto": List<dynamic>.from(cotizacionProducto.map((x) => x.toJson())),
        "detalleCotizacion": List<dynamic>.from(detalleCotizacion.map((x) => x.toJson())),
    };
}

class CotizacionProducto {
    final int idCotizacionProducto;
    final int idCotizacion;
    final int idProducto;
    final int? idColor;
    final int? idTalla;
    final int? idTamao;
    final int cantidad;
    final int subtotal;
    final String estado;
    final List<Image> images;

    CotizacionProducto({
        required this.idCotizacionProducto,
        required this.idCotizacion,
        required this.idProducto,
        required this.idColor,
        required this.idTalla,
        required this.idTamao,
        required this.cantidad,
        required this.subtotal,
        required this.estado,
        required this.images,
    });

    factory CotizacionProducto.fromJson(Map<String, dynamic> json) => CotizacionProducto(
        idCotizacionProducto: json["idCotizacionProducto"],
        idCotizacion: json["idCotizacion"],
        idProducto: json["idProducto"],
        idColor: json["idColor"],
        idTalla: json["idTalla"],
        idTamao: json["idTamaño"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        estado: json["estado"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idCotizacionProducto": idCotizacionProducto,
        "idCotizacion": idCotizacion,
        "idProducto": idProducto,
        "idColor": idColor,
        "idTalla": idTalla,
        "idTamaño": idTamao,
        "cantidad": cantidad,
        "subtotal": subtotal,
        "estado": estado,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    final int idImagenCotizacion;
    final String urlImagenCotizacion;
    final int idCotizacionProducto;

    Image({
        required this.idImagenCotizacion,
        required this.urlImagenCotizacion,
        required this.idCotizacionProducto,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        idImagenCotizacion: json["idImagenCotizacion"],
        urlImagenCotizacion: json["urlImagenCotizacion"],
        idCotizacionProducto: json["idCotizacionProducto"],
    );

    Map<String, dynamic> toJson() => {
        "idImagenCotizacion": idImagenCotizacion,
        "urlImagenCotizacion": urlImagenCotizacion,
        "idCotizacionProducto": idCotizacionProducto,
    };
}

class DetalleCotizacion {
    final int idDetalleCotizacion;
    final int idCotizacion;
    final DateTime fechaCotizacion;
    final DateTime fechaVencimiento;
    final int subtotal;

    DetalleCotizacion({
        required this.idDetalleCotizacion,
        required this.idCotizacion,
        required this.fechaCotizacion,
        required this.fechaVencimiento,
        required this.subtotal,
    });

    factory DetalleCotizacion.fromJson(Map<String, dynamic> json) => DetalleCotizacion(
        idDetalleCotizacion: json["idDetalleCotizacion"],
        idCotizacion: json["idCotizacion"],
        fechaCotizacion: DateTime.parse(json["fechaCotizacion"]),
        fechaVencimiento: DateTime.parse(json["fechaVencimiento"]),
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toJson() => {
        "idDetalleCotizacion": idDetalleCotizacion,
        "idCotizacion": idCotizacion,
        "fechaCotizacion": fechaCotizacion.toIso8601String(),
        "fechaVencimiento": fechaVencimiento.toIso8601String(),
        "subtotal": subtotal,
    };
}

class IdClienteNavigation {
    final int idCliente;
    final String nombre;
    final String apellido;

    IdClienteNavigation({
        required this.idCliente,
        required this.nombre,
        required this.apellido,
    });

    factory IdClienteNavigation.fromJson(Map<String, dynamic> json) => IdClienteNavigation(
        idCliente: json["idCliente"],
        nombre: json["nombre"],
        apellido: json["apellido"],
    );

    Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "nombre": nombre,
        "apellido": apellido,
    };
}
