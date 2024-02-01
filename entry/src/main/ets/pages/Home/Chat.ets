import { ChatItemType, MessageItemType } from './ChatList'
import router from '@ohos.router'
import inputMethod from '@ohos.inputMethod'
@Entry
@Component
export default struct Chat {

  scroller: Scroller = new Scroller()
  @State index: number = 0
  @State lastMessage: ChatItemType = {
    imagePath: '',
    nickName: '',
  }
  @State messageList: Array<MessageItemType> = []
  @StorageProp('point') currentBreakpoint: string = 'md'
  @StorageProp('clickNickName') @Watch('onChange') nickName: string = ''

  onChange() {
    setTimeout(() => {
      const chatInfo: string = AppStorage.Get('ChatInfo')
      if(chatInfo) {
        const data = chatInfo && JSON.parse(chatInfo) as ChatItemType;
        this.init(data)
      }
    }, 50)
  }
  onPageShow(){
    const message = router.getParams() as ChatItemType;
    this.init(message)
  }
  private imagePath: string = ''
  init(data: ChatItemType) {
    this.lastMessage = {
      nickName: data.nickName,
      imagePath: $rawfile(data.imagePath.params[0]),
      messageTime: data.messageTime,
      messageContent: data.messageContent,
    };

    this.imagePath = data.imagePath.params[0]

    this.messageList = [
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: '我要的不是雪，是有你的冬天'
      },
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: '我是配角怎敢吃醋，我是过客早有觉悟'
      },
      {
        state: 'right',
        icon: $rawfile('self.jpg'),
        message: '我拨动思念的弦，想着你惊鸿一面，相逢是上上的签，只一眼便是万年，这思念不知疲倦，勾勒出你的容颜，也不知我们何年何月，才能相见'
      },
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: '可惜我们终于来到 一个句号，窗外不愿飞的蜂鸟 也在哀悼'
      },
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: '你往前走 不要回头，上天让你错过谁都有理由，怕你受伤 独自承受，才把最好的人留到最后'
      },
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: '你往前走 不要回头，别再为旧人旧事湿了眼眸，别怕失去 学会放手，世上还有另一种幸福，叫曾经拥有'
      },
      {
        state: 'right',
        icon: $rawfile('self.jpg'),
        message: '往后求财我不求爱，如今我爱财爱己，过得风生水起，再也不吃你画的大饼，以后你爱谁都行，和我没有关系'
      },
      {
        state: 'right',
        icon: $rawfile('self.jpg'),
        message: '江湖一笑浪滔滔，红尘尽忘了，俱往矣何足言道，苍天一笑笑不老。'
      },
      {
        state: 'left',
        icon: this.lastMessage.imagePath,
        message: this.lastMessage.messageContent
      }
    ]

    this.scroller.scrollToIndex(this.messageList.length)
  }

  build(){
    Column(){
      Navigation(){
        List({space:20,initialIndex:0,scroller:this.scroller}){
          ForEach(this.messageList,(item:MessageItemType,index:number)=>{
            if (index === this.messageList.length-1) {
              ListItem(){
                Stack(){
                  Divider().vertical(false).color('#E6E6E6').opacity(0.6).margin({ left: 36, right: 36 })
                  Text(this.lastMessage.messageTime)
                    .backgroundColor('rgb(245,245,245)')
                    .fontColor(Color.Grey)
                    .padding({
                      left: 8,
                      right: 8
                    })
                }
              }
            }
            if (item.state === 'left') {
              ListItem(){
                Flex({direction:FlexDirection.Row}){
                  Image(item.icon)
                    .width(45)
                    .height(45)
                    .borderRadius(5)
                  Text(item.message)
                    .backgroundColor(Color.White)
                    .fontColor(Color.Black)
                    .padding(10)
                    .borderRadius(6)
                    .lineHeight(20)
                    .margin({left:10})
                }
              }.padding({right:55,top:10,bottom:20,left:10})
            }else{
              ListItem(){
                Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.End}){
                  Text(item.message)
                    .backgroundColor('rgb(63,182,57)')
                    .fontColor(Color.Black)
                    .padding(10)
                    .borderRadius(6)
                    .lineHeight(20)
                    .margin({right:10})
                  Image(item.icon)
                    .width(45)
                    .height(45)
                    .borderRadius(5)
                }
                .width('100%')
                .padding({left:55,top:10,bottom:20,right:10})
              }
            }
          })
        }.onScroll(()=>{
          console.log("开始滑动2")
          inputMethod.getController().hideSoftKeyboard()
        }).onDragStart(()=>{
          console.log("开始滑动")
          inputMethod.getController().hideSoftKeyboard()
        })
        .listDirection(Axis.Vertical)
        .backgroundColor('rgb(245,245,245)')
        .height('92%')

        Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween}){
          Image($r('app.media.voice'))
            .width(30)
            .height(30)
            .margin({top:5})
          TextInput({
            text:this.message
          }).enterKeyType(EnterKeyType.Send)
            .width('62%')
            .height(40)
            .backgroundColor(Color.White)
            .borderRadius(5)
            .margin({left:4,right:4})
            .onChange((value)=>this.changeInput(value))
            .onSubmit(()=>this.sendMessage())
          Image($r('app.media.emoj'))
            .width(30)
            .height(30)
            .margin({top:5})
          if (this.isShowSendBtn){
            Button('发送',{type:ButtonType.Normal,stateEffect:true})
              .backgroundColor(Color.Green)
              .borderRadius(6)
              .height(30)
              .margin({top:5,left:5})
              .onClick(()=>this.sendMessage())
          }else{
            Image($r('app.media.more'))
              .width(30)
              .height(30)
              .margin({top:5})
          }
        }.padding({top:10,left:15,right:15})
        .width('100%')
        .height(90)
        .backgroundColor('rgb(240,240,240)')
      }.title(this.NavigationTitle())
      .mode(NavigationMode.Stack)
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(this.currentBreakpoint === 'lg')
      .menus(this.NavigationMenus())
      .size({ width: '100%', height: '100%' })
      .backgroundColor('rgb(237,237,237)')
      .backButtonIcon($r('app.media.ic_public_arrow_left'))
    }.width('100%')
    .height('100%')
  }
  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏
    Row() {
      Image($r('app.media.ic_public_more'))
        .size({ width: 24, height: 24 })
        .margin({ top: 15 })

    }
    .justifyContent(FlexAlign.End)
    .onClick(() => {
      router.pushUrl({
        url:'pages/Home/UserDetail',
        params: {
          imageIcon: this.imagePath
        }
      })
    })
  }
  @Builder NavigationTitle() {
    Row(){
      Text(this.lastMessage.nickName).fontWeight(FontWeight.Bold).fontSize(18)
        .width('100')
    }
    .width('80%')
    .justifyContent(FlexAlign.Center)
  }

  @State message: string = '';
  @State isShowSendBtn: boolean = false;
  private sendMessage() {
    this.messageList.push({
      isNewSend: true,
      state: 'right',
      icon: $rawfile('self.jpg'),
      message: this.message,
    })

    this.message = ''
    this.isShowSendBtn = false
    this.scroller.scrollToIndex(this.messageList.length)
  }

  changeInput(val: string) {
    this.message = val
    console.log('******************', val, this.message)
    this.isShowSendBtn = true
    if(!val) {
      this.isShowSendBtn = false
    }
  }
}