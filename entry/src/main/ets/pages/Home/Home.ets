import { ChatItemType } from './ChatList'
import router from '@ohos.router'
import { HOME_CHAT } from '../../common/RouterData'
import { MessageRow } from './view/MessageRow'
import { MenuRow } from './view/MenuRow'
@Entry
@Component
export default struct Home {

  @StorageProp('point') currentBreakpoint: string = 'md'
  @Provide("menuOpacity")   menuOpacity:number = 0
  private copyChatList: Array<ChatItemType> = []
  @State chatList: Array<ChatItemType> = []
  onPageHide(){
    this.menuOpacity = 0
  }

  aboutToAppear() {
    this.chatList = [
      {
        imagePath: $rawfile('icon1.jpg'),
        nickName: '熊炼',
        messageContent: '觉悟',
        messageTime: '09:24',
        newMessageAmount: 2
      },
      {
        imagePath: $rawfile('icon2.jpg'),
        nickName: 'Jason',
        messageContent: '句号',
        messageTime: '09:24',
      },
      {
        imagePath: $rawfile('icon3.jpg'),
        nickName: '卡酷',
        messageContent: '洗洗睡吧',
        messageTime: '19:24',
        newMessageAmount: 6
      },
      {
        imagePath: $rawfile('icon4.jpg'),
        nickName: 'AGlomBo',
        messageContent: '新年快乐，万事如意，心想事成！',
        messageTime: '15:24',
      },
      {
        imagePath: $rawfile('icon5.jpg'),
        nickName: '梦舟',
        messageContent: '往后求财我不求爱，\n如今我爱财爱己，\n过得风生水起，\n再也不吃你画的大饼，\n以后你爱谁都行，\n和我没有关系',
        messageTime: '16:24',
        newMessageAmount: 5
      },
      {
        imagePath: $rawfile('icon6.jpg'),
        nickName: '飞鱼',
        messageContent: '爱财爱己',
        messageTime: '11:24',
        newMessageAmount: 9
      },
      {
        imagePath: $rawfile('icon7.jpg'),
        nickName: '俗人',
        messageContent: '风生水起',
        messageTime: '11:34',
      },
      {
        imagePath: $rawfile('icon8.jpg'),
        nickName: '啧啧',
        messageContent: '你往前走 不要回头，别再为旧人旧事湿了眼眸，别怕失去 学会放手，世上还有另一种幸福，叫曾经拥有',
        messageTime: '11:44',
      },
      {
        imagePath: $rawfile('icon9.jpg'),
        nickName: 'Wu',
        messageContent: '你往前走 不要回头，上天让你错过谁都有理由，怕你受伤 独自承受，才把最好的人留到最后',
        messageTime: '11:14',
      },
    ]
    this.copyChatList = JSON.parse(JSON.stringify(this.chatList))
  }

  private inputChange(val) {
    if(!val) {
      this.chatList = this.copyChatList
    } else {
      this.chatList = this.chatList.filter((item: ChatItemType) => item.nickName.includes(val) || item.messageContent.includes(val))
    }
  }

  private onClickMenu(val) {
    console.log('onClickMenu==>', val)
    this.menuOpacity = 0
    if(val === '收付款') {
      router.pushUrl({
        url: 'pages/MainPage/MainPage'
      })
    }
  }
  build(){
    Column(){
      Navigation(){
        Stack({alignContent:Alignment.TopEnd}){
          Column(){
            TextInput({placeholder:"搜索"})
              .width('92%')
              .height(40)
              .backgroundColor(Color.White)
              .margin({
                top:-36
              })
              .borderRadius(5)
              .textAlign(this.currentBreakpoint === 'lg' ? TextAlign.Start:TextAlign.Center)
              .onChange((value)=>{
                this.inputChange(value)
              })
            List(){
              ForEach(this.chatList,(item:ChatItemType)=>{
                ListItem(){
                  MessageRow({
                    imagePath:item.imagePath,
                    nickName:item.nickName,
                    messageTime:item.messageTime,
                    messageContent:item.messageContent,
                    newMessageAmount:item.newMessageAmount
                  })
                }.onClick(()=>{
                  const obj:ChatItemType = {
                    imagePath:item.imagePath,
                    nickName:item.nickName,
                    messageContent:item.messageContent,
                    messageTime:item.messageTime
                  }
                  if(this.currentBreakpoint === 'lg') {
                    AppStorage.SetOrCreate('isClickList', true)
                    AppStorage.SetOrCreate('clickNickName', obj.nickName)
                    AppStorage.SetOrCreate('ChatInfo', JSON.stringify(obj))
                    return
                  }
                  router.pushUrl({
                    url:HOME_CHAT,
                    params: obj
                  })
                })
              })
            }.divider({strokeWidth:2,color:'rgb(247,247,247)',startMargin:60,endMargin:0})
            .margin({top:17})
            .padding({left:17,right:17})
            .backgroundColor(Color.White)
            .width('100%')
            .layoutWeight(1)
          }.onClick(() => {
            this.menuOpacity = 0
          })

          Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.Center}){
            Path()
              .width(20)
              .height(20)
              .commands('M25 0 L50 50 L0 50 Z')
              .fill('rgb(76,76,76)')
              .stroke('rgb(76,76,76)')
              .padding(0)
              .margin({
                top: -55
              })
              .position({x:96,y:0})
            List(){
              ListItem(){
                MenuRow({imagePath:$r('app.media.menu_group'),titleString:'发起群聊', onClickMenu: this.onClickMenu})
              }
              ListItem(){
                MenuRow({imagePath:$r('app.media.menu_add'),titleString:'添加朋友', onClickMenu: this.onClickMenu})
              }
              ListItem(){
                MenuRow({imagePath:$r('app.media.menu_scan'),titleString:'扫一扫', onClickMenu: this.onClickMenu})
              }
              ListItem(){
                MenuRow({imagePath:$r('app.media.menu_purchase'),titleString:'收付款', onClickMenu: this.onClickMenu})
              }
            }.margin(0)
            .borderRadius(5)

            .padding({left:12})
            .divider({ strokeWidth: 1, color: 'rgb(130,130,130)', startMargin: 20, endMargin: 0 }) // 每行之间的分界线
            .backgroundColor('rgb(76,76,76)')
            .width(130)
            .height(180)
          }.opacity(this.menuOpacity)
          .width(130)
          .height(200)
          .margin({right:10,top:-55})
          .visibility(this.menuOpacity==0?Visibility.Hidden:Visibility.Visible)
        }.margin({ top: this.currentBreakpoint !== 'lg' ? 40 : -5 })
      }.mode(NavigationMode.Stack)
      .title(this.currentBreakpoint !== 'lg' ? this.NavigationTitle() : '')
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .menus(this.NavigationMenus())
      .size({ width: '100%', height: '100%' })
      .backgroundColor('rgb(237,237,237)')
    }.width('100%')
    .layoutWeight(1)
    .onTouch((event: TouchEvent) => {
      const obj: { x: number; y: number; } = event.touches[0];
      const x: number = obj.x;
      const y: number = obj.y;
      if (((x > 220 && x < 346) && (y > 27 && y < 227))) {

      } else {
        this.menuOpacity = 0
      }
    })
  }
  @Builder NavigationTitle() {
    Column(){
      Text("微信"+`(${this.copyChatList.length})`).fontWeight(FontWeight.Bold).fontSize(18)
    }
    .padding({
      top: 12,
      bottom: 12
    })
    .margin({
      top: -50,
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
  @Builder NavigationMenus(){
    Row() {
      Image($r('app.media.we_add'))
        .size({ width: 24, height: 24 })
        .margin({ top: 15 })
        .onClick(()=>{
          animateTo({
            duration: 200,
          }, () => {
            if(this.menuOpacity == 0){
              this.menuOpacity = 1
            }else if(this.menuOpacity == 1){
              this.menuOpacity = 0
            }
          })
        })
    }.justifyContent(FlexAlign.End)
  }
}