import router from '@ohos.router'
import { ToolType } from '@ohos.multimodalInput.touchEvent'
@Entry
@Component
export default struct UserDetail {

  @State icon: Resource = $rawfile('self.jpg')
  onPageShow(){
    const icon = router.getParams() as {imageIcon:string}
    this.icon = $rawfile(icon.imageIcon)
  }
  @Builder NavigationTitle(){
    Row(){
      Text('聊天记录').fontSize(18).fontColor(Color.Black).fontWeight(FontWeight.Normal)
        .width('100%')
    }.alignItems(VerticalAlign.Center)
    .width('80%')
  }
  @Builder RightIconBuilder(){
    Image($r('app.media.ic_public_arrow_right')).width(22)
  }
  @Builder ToggleBtnBuilder(isOn: boolean){
    Toggle({type:ToggleType.Switch,isOn:isOn})
      .selectedColor(Color.Green)
      .switchPointColor(Color.White)
      .onChange((isOn:boolean)=>{
        console.info('Component status:' + isOn)
      })
  }
  build(){
    Stack(){
      Navigation(){
        List({space:12}){
          ListItem(){
            Row({space:12}){
              Image(this.icon).width(60).height(60).borderRadius(5)
              Row(){
                Image($r('app.media.add_image')).width(40)
              }.width(60)
              .height(60)
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .borderColor('#E6E6E6')
              .borderWidth(1)
              .borderRadius(10)
            }.listItemStyle().justifyContent(FlexAlign.Start)
          }
          ListItem(){
            Row(){
              Text('查找聊天记录')
              this.RightIconBuilder()
            }.listItemStyle()
          }
        }
      }.title(this.NavigationTitle())
      .mode(NavigationMode.Stack)
      .hideBackButton(false)
      .size({width:'100%',height:'100%'})
      .backgroundColor('rgb(237,237,237)')
      .backButtonIcon($r('app.media.ic_public_arrow_left'))
    }.width('100%')
    .height('100%')
  }
}

@Extend(Row) function listItemStyle(pd?:number){
  .justifyContent(FlexAlign.SpaceBetween)
  .width('100%')
  .padding({
    top:pd || 16,
    bottom:pd || 16,
    left:12,
    right:12
  }).backgroundColor(Color.White)
}