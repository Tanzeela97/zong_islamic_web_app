class IslamicNameModel {
  late final int totalPage;
  late final String previousPage;
  late final String nextPage;
  late final String page;
  late final List<Data> data;

  IslamicNameModel(
      {required this.totalPage,
      required this.previousPage,
      required this.nextPage,
      required this.page,
      required this.data});

  IslamicNameModel.fromJson(Map<String, dynamic> json) {
    // return IslamicName(totalPage: json['total_page'],
    //     previousPage: json['previous_page'],
    //     nextPage: json['next_page'],
    //     page:json['page'],
    //     data: json['data'].forE);
    totalPage = json['total_page'];
    previousPage = json['previous_page'];
    nextPage = json['next_page'];
    page = json['page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['total_page'] = this.totalPage;
  //   data['previous_page'] = this.previousPage;
  //   data['next_page'] = this.nextPage;
  //   data['page'] = this.page;
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Data {
  late final List<A> a;
  late final List<A> b;
  late final List<A> c;
  late final List<A> d;
  late final List<A> e;
  late final List<A> f;
  late final List<A> g;
  late final List<A> h;
  late final List<A> i;
  late final List<A> j;
  late final List<A> k;
  late final List<A> l;
  late final List<A> m;
  late final List<A> n;
  late final List<A> o;
  late final List<A> p;
  late final List<A> q;
  late final List<A> r;
  late final List<A> s;
  late final List<A> t;
  late final List<A> u;
  late final List<A> v;
  late final List<A> w;
  late final List<A> x;
  late final List<A> y;
  late final List<A> z;

  Data(
      {required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.e,
      required this.f,
      required this.g,
      required this.h,
      required this.i,
      required this.j,
      required this.k,
      required this.l,
      required this.m,
      required this.n,
      required this.o,
      required this.p,
      required this.q,
      required this.r,
      required this.s,
      required this.t,
      required this.u,
      required this.v,
      required this.w,
      required this.x,
      required this.y,
      required this.z});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['A'] != null) {
      a = <A>[];
      json['A'].forEach((v) {
        a.add(new A.fromJson(v));
      });
    }
    if (json['B'] != null) {
      b = <A>[];
      json['B'].forEach((v) {
        b.add(new A.fromJson(v));
      });
    }
    if (json['C'] != null) {
      c = <A>[];
      json['C'].forEach((v) {
        c.add(new A.fromJson(v));
      });
    }
    if (json['D'] != null) {
      d = <A>[];
      json['D'].forEach((v) {
        d.add(new A.fromJson(v));
      });
    }
    if (json['E'] != null) {
      e = <A>[];
      json['E'].forEach((v) {
        e.add(new A.fromJson(v));
      });
    }
    if (json['F'] != null) {
      f = <A>[];
      json['F'].forEach((v) {
        f.add(new A.fromJson(v));
      });
    }
    if (json['G'] != null) {
      g = <A>[];
      json['G'].forEach((v) {
        g.add(new A.fromJson(v));
      });
    }
    if (json['H'] != null) {
      h = <A>[];
      json['H'].forEach((v) {
        h.add(new A.fromJson(v));
      });
    }
    if (json['I'] != null) {
      i = <A>[];
      json['I'].forEach((v) {
        i.add(new A.fromJson(v));
      });
    }
    if (json['J'] != null) {
      j = <A>[];
      json['J'].forEach((v) {
        j.add(new A.fromJson(v));
      });
    }
    if (json['K'] != null) {
      k = <A>[];
      json['K'].forEach((v) {
        k.add(new A.fromJson(v));
      });
    }
    if (json['L'] != null) {
      l = <A>[];
      json['L'].forEach((v) {
        l.add(new A.fromJson(v));
      });
    }
    if (json['M'] != null) {
      m = <A>[];
      json['M'].forEach((v) {
        m.add(new A.fromJson(v));
      });
    }
    if (json['N'] != null) {
      n = <A>[];
      json['N'].forEach((v) {
        n.add(new A.fromJson(v));
      });
    }
    if (json['O'] != null) {
      o = <A>[];
      json['O'].forEach((v) {
        o.add(new A.fromJson(v));
      });
    }
    if (json['P'] != null) {
      p = <A>[];
      json['P'].forEach((v) {
        p.add(new A.fromJson(v));
      });
    }
    if (json['Q'] != null) {
      q = <A>[];
      json['Q'].forEach((v) {
        q.add(new A.fromJson(v));
      });
    }
    if (json['R'] != null) {
      r = <A>[];
      json['R'].forEach((v) {
        r.add(new A.fromJson(v));
      });
    }
    if (json['S'] != null) {
      s = <A>[];
      json['S'].forEach((v) {
        s.add(new A.fromJson(v));
      });
    }
    if (json['T'] != null) {
      t = <A>[];
      json['T'].forEach((v) {
        t.add(new A.fromJson(v));
      });
    }
    if (json['U'] != null) {
      u = <A>[];
      json['U'].forEach((v) {
        u.add(new A.fromJson(v));
      });
    }
    if (json['V'] != null) {
      v = <A>[];
      json['V'].forEach((item) {
        v.add(new A.fromJson(item));
      });
    }
    if (json['W'] != null) {
      w = <A>[];
      json['W'].forEach((v) {
        w.add(new A.fromJson(v));
      });
    }
    if (json['X'] != null) {
      x = <A>[];
      json['X'].forEach((v) {
        x.add(new A.fromJson(v));
      });
    }
    if (json['Y'] != null) {
      y = <A>[];
      json['Y'].forEach((v) {
        y.add(new A.fromJson(v));
      });
    }
    if (json['Z'] != null) {
      z = <A>[];
      json['Z'].forEach((v) {
        z.add(new A.fromJson(v));
      });
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.a != null) {
//     data['A'] = this.a!.map((v) => v.toJson()).toList();
//   }
//   if (this.b != null) {
//     data['B'] = this.b!.map((v) => v.toJson()).toList();
//   }
//   if (this.c != null) {
//     data['C'] = this.c!.map((v) => v.toJson()).toList();
//   }
//   if (this.d != null) {
//     data['D'] = this.d!.map((v) => v.toJson()).toList();
//   }
//   if (this.e != null) {
//     data['E'] = this.e!.map((v) => v.toJson()).toList();
//   }
//   if (this.f != null) {
//     data['F'] = this.f!.map((v) => v.toJson()).toList();
//   }
//   if (this.g != null) {
//     data['G'] = this.g!.map((v) => v.toJson()).toList();
//   }
//   if (this.h != null) {
//     data['H'] = this.h!.map((v) => v.toJson()).toList();
//   }
//   if (this.i != null) {
//     data['I'] = this.i!.map((v) => v.toJson()).toList();
//   }
//   if (this.j != null) {
//     data['J'] = this.j!.map((v) => v.toJson()).toList();
//   }
//   if (this.k != null) {
//     data['K'] = this.k!.map((v) => v.toJson()).toList();
//   }
//   if (this.l != null) {
//     data['L'] = this.l!.map((v) => v.toJson()).toList();
//   }
//   if (this.m != null) {
//     data['M'] = this.m!.map((v) => v.toJson()).toList();
//   }
//   if (this.n != null) {
//     data['N'] = this.n!.map((v) => v.toJson()).toList();
//   }
//   if (this.o != null) {
//     data['O'] = this.o!.map((v) => v.toJson()).toList();
//   }
//   if (this.p != null) {
//     data['P'] = this.p!.map((v) => v.toJson()).toList();
//   }
//   if (this.q != null) {
//     data['Q'] = this.q!.map((v) => v.toJson()).toList();
//   }
//   if (this.r != null) {
//     data['R'] = this.r!.map((v) => v.toJson()).toList();
//   }
//   if (this.s != null) {
//     data['S'] = this.s!.map((v) => v.toJson()).toList();
//   }
//   if (this.t != null) {
//     data['T'] = this.t!.map((v) => v.toJson()).toList();
//   }
//   if (this.u != null) {
//     data['U'] = this.u!.map((v) => v.toJson()).toList();
//   }
//   if (this.v != null) {
//     data['V'] = this.v!.map((v) => v.toJson()).toList();
//   }
//   if (this.w != null) {
//     data['W'] = this.w!.map((v) => v.toJson()).toList();
//   }
//   if (this.x != null) {
//     data['X'] = this.x!.map((v) => v.toJson()).toList();
//   }
//   if (this.y != null) {
//     data['Y'] = this.y!.map((v) => v.toJson()).toList();
//   }
//   if (this.z != null) {
//     data['Z'] = this.z!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class A {
  String? kwid;
  String? name;
  String? meaning;
  String? gender;
  String? alpha;
  int? isFavourite;
  A(
      {this.kwid,
      this.name,
      this.meaning,
      this.gender,
      this.alpha,
      this.isFavourite});

  A.fromJson(Map<String, dynamic> json) {
    kwid = json['kwid'];
    name = json['name'];
    meaning = json['meaning'];
    gender = json['gender'];
    alpha = json['alpha'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kwid'] = this.kwid;
    data['name'] = this.name;
    data['meaning'] = this.meaning;
    data['gender'] = this.gender;
    data['alpha'] = this.alpha;
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}
//
// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));
//
// String welcomeToJson(Welcome data) => json.encode(data.toJson());
//
// class Welcome {
//   Welcome({
//    required this.totalPage,
//    required this.previousPage,
//   required  this.nextPage,
//    required this.page,
//    required this.data,
//   });
//
//   int totalPage;
//   String previousPage;
//   String nextPage;
//   String page;
//   List<Map<String, List<Datum>>> data;
//
//   factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         totalPage: json["total_page"],
//         previousPage: json["previous_page"],
//         nextPage: json["next_page"],
//         page: json["page"],
//         data: List<Map<String, List<Datum>>>.from(json["data"].map((x) =>
//             Map.from(x).map((k, v) => MapEntry<String, List<Datum>>(
//                 k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total_page": totalPage,
//         "previous_page": previousPage,
//         "next_page": nextPage,
//         "page": page,
//         "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, List<dynamic>.from(v.map((x) => x.toJson())))))),
//       };
// }
//
// class Datum {
//   Datum({
//     required this.kwid,
//     required this.name,
//     required this.meaning,
//     required this.gender,
//     required this.alpha,
//     required this.isFavourite,
//   });
//
//   String kwid;
//   String name;
//   String meaning;
//   Gender gender;
//   Alpha alpha;
//   int isFavourite;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         kwid: json["kwid"],
//         name: json["name"],
//         meaning: json["meaning"],
//         gender: genderValues.map[json["gender"]]!,
//         alpha: alphaValues.map[json["alpha"]]!,
//         isFavourite: json["is_favourite"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "kwid": kwid,
//         "name": name,
//         "meaning": meaning,
//         "gender": genderValues.reverse[gender],
//         "alpha": alphaValues.reverse[alpha],
//         "is_favourite": isFavourite,
//       };
// }
//
// enum Alpha {
//   A,
//   B,
//   C,
//   D,
//   E,
//   F,
//   G,
//   H,
//   I,
//   J,
//   K,
//   L,
//   M,
//   N,
//   O,
//   P,
//   Q,
//   R,
//   S,
//   T,
//   U,
//   V,
//   W,
//   X,
//   Y,
//   Z
// }
//
// final alphaValues = EnumValues({
//   "A": Alpha.A,
//   "B": Alpha.B,
//   "C": Alpha.C,
//   "D": Alpha.D,
//   "E": Alpha.E,
//   "F": Alpha.F,
//   "G": Alpha.G,
//   "H": Alpha.H,
//   "I": Alpha.I,
//   "J": Alpha.J,
//   "K": Alpha.K,
//   "L": Alpha.L,
//   "M": Alpha.M,
//   "N": Alpha.N,
//   "O": Alpha.O,
//   "P": Alpha.P,
//   "Q": Alpha.Q,
//   "R": Alpha.R,
//   "S": Alpha.S,
//   "T": Alpha.T,
//   "U": Alpha.U,
//   "V": Alpha.V,
//   "W": Alpha.W,
//   "X": Alpha.X,
//   "Y": Alpha.Y,
//   "Z": Alpha.Z
// });
//
// enum Gender { MALE, GENDER_MALE }
//
// final genderValues =
//     EnumValues({"MALE": Gender.GENDER_MALE, "Male": Gender.MALE});
//
// class EnumValues<T> {
//   late Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
