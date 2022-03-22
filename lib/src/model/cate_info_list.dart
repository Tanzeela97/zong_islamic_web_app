class CateInfoList {
  String? contentId;
  String? contentCatId;
  String? contentTitle;
  String? contentDescEn;
  String? contentImage;
  String? contentVdo;

  CateInfoList({
    this.contentId,
    this.contentCatId,
    this.contentTitle,
    this.contentDescEn,
    this.contentImage,
    this.contentVdo,
  });

  CateInfoList.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentCatId = json['content_cat_id'];
    contentTitle = json['content_title'];

    contentDescEn = json['content_desc_en'];


    contentImage = json['content_image'];
    contentVdo = json['content_vdo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_id'] = this.contentId;
    data['content_cat_id'] = this.contentCatId;
    data['content_title'] = this.contentTitle;
    data['content_desc_en'] = this.contentDescEn;
    data['content_image'] = this.contentImage;
    data['content_vdo'] = this.contentVdo;
    return data;
  }
}
