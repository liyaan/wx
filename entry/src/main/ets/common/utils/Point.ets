
import mediaQuery from '@ohos.mediaquery'
class Point{
  private point:string = 'md'
  private sm:mediaQuery.MediaQueryListener
  private md:mediaQuery.MediaQueryListener
  private lg:mediaQuery.MediaQueryListener
  
  private update(point:string){
    if (this.point != point) {
      this.point = point
      AppStorage.Set<string>('point',this.point)
    }
  }
  
  private isSM = (md:mediaQuery.MediaQueryResult)=>{
    if (md.matches){
      this.update('sm')
    }
  }

  private isMD = (md:mediaQuery.MediaQueryResult)=>{
    if (md.matches){
      this.update('md')
    }
  }
  private isLG = (md:mediaQuery.MediaQueryResult)=>{
    if (md.matches){
      this.update('lg')
    }
  }
  public registerPoint(){
    this.sm = mediaQuery.matchMediaSync('(320vp<=width<600vp)')
    this.sm.on('change',this.isSM)

    this.md = mediaQuery.matchMediaSync('(600vp<=width<840vp)')
    this.md.on('change',this.isMD)

    this.lg = mediaQuery.matchMediaSync('(840vp<=width)')
    this.lg.on('change',this.isLG)
  }

  public unRegisterPoint(){
    this.sm.off('change',this.isSM)
    this.md.off('change',this.isMD)
    this.lg.off('change',this.isLG)
  }
}

export default new Point()