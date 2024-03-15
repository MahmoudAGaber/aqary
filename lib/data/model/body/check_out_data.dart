class CheckOutData{
  String? orderType;
  String? freeDeliveryType;
  double? amount;
 // double? deliveryCharge;
  double? placeOrderDiscount;
  String? couponCode;
  String? orderNote;

  CheckOutData({
     this.orderType,
     this.freeDeliveryType,
     this.amount,
   //  this.deliveryCharge,
     this.placeOrderDiscount,
     this.couponCode,
     this.orderNote,
  });

  CheckOutData copyWith({String? orderNote, double? discount, double? deliveryCharge}) {
    if(orderNote != null) {
      this.orderNote = orderNote;
    }
    if(discount != null) {
      placeOrderDiscount = discount;
    }
    // if(deliveryCharge != null) {
    //   this.deliveryCharge = deliveryCharge;
    // }
    return this;
  }


}