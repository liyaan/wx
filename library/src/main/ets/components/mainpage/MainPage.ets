@Entry
@Component
export  struct MainPage {
  @Builder NavigationTitle(){
    Column(){
      Text('收付款')
        .width('100%')
        .fontColor(Color.White)
    }
    .width('88%')
    .justifyContent(FlexAlign.Center)
  }
  private value: string = '收款二维码'
  private dataList: Array<any> = [
    {
      icon: $rawfile('01.svg'),
      label: '二维码收款'
    },
    {
      icon: $rawfile('02.svg'),
      label: '赞赏吗'
    },
    {
      icon: $rawfile('03.svg'),
      label: '群收款'
    },
    {
      icon: $rawfile('04.svg'),
      label: '面对面红包'
    },
    {
      icon: $rawfile('05.svg'),
      label: '向银行卡或手机号转账'
    }
  ]
  private hoverBgColor: string = '#53e587'
  scroller: Scroller = new Scroller()
  build() {
    Stack(){
      Navigation(){
        List({space:0}){
          ListItem(){
            Column(){
              Row(){
                Image($rawfile('qCodeIcon.svg')).margin({ right: 6 }).width(18)
                Text('使用付款码').fontColor('#8ce95e')
              }.padding(24)
              .width('100%')
              .justifyContent(FlexAlign.Start)
              Divider().vertical(false).color('#E6E6E6').opacity(0.6).margin({ left: 20, right: 20 })

              Column() {
                Row() {
                  Text('轻触可查看付款吗数字').fontSize(12).fontColor(Color.Gray)
                }.height(36)
                Image($rawfile('code.svg')).height(80).width(220)
                QRCode(this.value).width(120).height(120).margin(24)
              }
              Divider().vertical(false).color('#E6E6E6').opacity(0.6).margin({ left: 20, right: 20 })
              Column() {
                Row() {
                  Row(){
                    Image($rawfile('pay.svg'))
                      .width(24)
                      .height(24)

                    Column() {
                      Text('交通银行 信用卡 (9070)').fontSize(16)
                      Text('优先使用此付款方式').fontSize(12).margin({ top: 6 }).fontColor(Color.Gray)
                    }
                    .margin({ left: 8 })
                    .alignItems(HorizontalAlign.Start)
                  }

                  Image($rawfile('ic_public_arrow_down_0.svg'))
                    .width(24)
                    .height(24)
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .padding(12)
              .width('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Start)
            }
            .backgroundColor(Color.White)
            .borderRadius(6)
          }
          .backgroundColor('#00fb59')
          .margin({
            bottom: 12
          })

          ForEach(this.dataList, (item, index: number) => {
            ListItem() {
              Column() {
                Row() {
                  Row() {
                    Image(item.icon)
                      .width(22)
                      .margin({ right: 6 })
                    Text(item.label)
                      .fontSize(16).fontColor(Color.White)
                      .textAlign(TextAlign.Start)
                  }
                  Image($rawfile('ic_public_arrow_right.svg')).width(24)
                }
                .padding(14)
                .justifyContent(FlexAlign.SpaceBetween).width('100%')
                if(index !== this.dataList.length - 1) {
                  Divider().vertical(false).color('#E6E6E6').opacity(0.6).margin({ left: 20, right: 20 })
                }
              }
            }
            .onHover((isHover: boolean) => {
              this.hoverBgColor = isHover ? '#707070' : ''
            })
            .backgroundColor(this.hoverBgColor)
            .width('100%')
          })
        }
        .margin({
          top: 0,
          bottom: 12,
          left: 12,
          right: 12
        })
        .borderRadius(6)
      }
      .title(this.NavigationTitle())
      .mode(NavigationMode.Stack)
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(false)
      .menus([])
      .size({ width: '100%', height: '100%' })
      .backgroundColor('#00fb59')
      .backButtonIcon($rawfile('ic_public_arrow_left.svg'))
    }
  }
}