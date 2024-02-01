@Component
export struct MenuRow {
  onClickMenu: (val: Length) => void;
  imagePath: ResourceStr
  titleString: string
  @Consume("menuOpacity") menuOpacity: number
  build(){
    Flex({direction:FlexDirection.Row,alignItems:ItemAlign.Center}){
      Image(this.imagePath)
        .width(21)
        .height(21)

      Text(this.titleString)
        .fontColor(Color.White)
        .fontSize(18)
        .margin({left:8})
    }
    .height(45)
    .onClick(() => {
      this.menuOpacity = 0
      this.onClickMenu(this.titleString);
    })
  }
}