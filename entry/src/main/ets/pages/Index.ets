import point from  '../common/utils/Point'
import constantsData from '../common/viewModel/ConstantsData'
import Contacts from './contact/Contacts'
import Discover from './discover/Discover'
import Home from './Home/Home'
import My from './my/My'
@Entry
@Component
struct Index {
  private controller:TabsController = new TabsController()
  @State currentIndex:number = 0
  @State selectColor:string = 'rgb(0,196,104)'
  @StorageProp('point') point:string = 'lg'

  @StorageProp('isClickList') isClickList:boolean = false
  private tabsImage: Array<ResourceStr> = [
    $r('app.media.chat_tab_0'),
    $r('app.media.chat_tab_1'),
    $r('app.media.chat_tab_2'),
    $r('app.media.chat_tab_3'),
  ]
  aboutToAppear(){
    point.registerPoint()
  }
  aboutToDisappear(){
    point.unRegisterPoint()
  }
  build() {
    Column(){
      if (this.point!=='lg'){
        Tabs({barPosition:BarPosition.End,controller:this.controller}){
          TabContent(){
            Home()
          }.tabBar(this.TabBuilder(0,true,129))
          TabContent(){
            Contacts()
          }.tabBar(this.TabBuilder(1))
          TabContent(){
            Discover()
          }.tabBar(this.TabBuilder(2))
          TabContent(){
            My()
          }.tabBar(this.TabBuilder(3))
        }
        .vertical(false)
        .barHeight(56)
        .onChange((index: number) => {
          this.currentIndex = index
        })
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.index_bg'))
      }else{
        Row(){
          Column(){
            Column(){
              Image($rawfile('self.jpg')).width(60).borderRadius(6)
            }.alignItems(HorizontalAlign.Center)
            .width('100%')
            .margin({
              top:48,bottom:24
            })
            ForEach(constantsData.getHomeTab(), (item: string, index: number) => {
              this.TabLgBuilder(index)
            })
          }.alignItems(HorizontalAlign.Center)
          .width('8%')
          .height('100%')
          .backgroundColor($r('app.color.index_lg_bg'))
          if(this.currentIndex === 0) {

          }else if(this.currentIndex === 1){

          }else if(this.currentIndex === 2){

          }else if(this.currentIndex === 3){

          }
        }
      }
    }.width('100%')
    .height('100%')
  }
  @Builder TabLgBuilder(index: number) {
    Column(){
      Image(this.tabsImage[index])
        .fillColor(this.currentIndex === index ? '#519d01' : '#E6E6E6')
        .width(36)
        .height(36)
        .margin({ bottom: 18 })
        .objectFit(ImageFit.Contain)
        .onClick(() => { this.currentIndex = index })
    }.width('100%').height(60)
  }
  @Builder TabBuilder(index:number,isBadge?:boolean,num?:number){

    Stack(){
      if (isBadge){
        Row(){
          if (num) {
            Text(`${num>100 ? '99+':num}`).fontSize(8).fontColor(Color.White)
          }
        }.justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width(num ? 18 : 8)
        .height(num ? 18 : 8)
        .borderRadius(50)
        .zIndex(999)
        .backgroundColor(Color.Red)
        .position({
          x: num ? '54%' : '58%',
          y: num ? -5 : -2
        })
      }
      Column(){

        Image(this.currentIndex === index ? `/images/wetab${index}1.png` : `/images/wetab${index}0.png`)
          .width(24)
          .height(24)
          .margin({bottom:4})
          .objectFit(ImageFit.Contain)
        Text(constantsData.getHomeTab()[index])
          .fontColor(this.currentIndex === index ? this.selectColor : $r('app.color.tab_text_color'))
          .fontSize(10)
          .lineHeight(14)
      }.width('100%')
    }
  }
}