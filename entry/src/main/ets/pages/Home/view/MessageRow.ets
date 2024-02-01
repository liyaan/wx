@Component
export struct MessageRow{
  private imagePath: ResourceStr
  private nickName: string
  private messageTime: string
  private messageContent: string
  private newMessageAmount?: number
  build(){
    Flex({direction:FlexDirection.Row,alignItems:ItemAlign.Center}){
      Stack(){
        if (this.newMessageAmount){
          Row(){
            Text(`${this.newMessageAmount}`).fontColor(Color.White).fontSize(12)
          }.width(16)
          .height(16)
          .backgroundColor(Color.Red)
          .borderRadius(50)
          .zIndex(99)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .position({
            x:'98%',
            y:-5
          })
        }
        Image(this.imagePath)
          .width(60)
          .height(60)
          .objectFit(ImageFit.Cover)
          .borderRadius(5)
      }
      Flex({direction:FlexDirection.Column}){
        Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween}){
          Text(this.nickName)
            .fontColor('rgb(15,15,15)')
            .fontSize(20)
          Text(this.messageTime)
            .fontColor('rgb(210,210,210)')
            .fontSize(13)
        }
        Text(this.messageContent)
          .fontColor('rgb(190,190,190)')
          .fontSize(17)
          .margin({top:10})
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(1)
      }.height(55)
      .margin({left:20})
    }.height(80)
  }
}