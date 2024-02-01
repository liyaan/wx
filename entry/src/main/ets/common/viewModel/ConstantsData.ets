
class ConstantsData{

   getHomeTab():any{
    let arr= []
     arr.push('微信')
     arr.push('通讯录')
     arr.push('发现')
     arr.push('我的')
     return arr
  }

}

let constantsData = new ConstantsData();

export default constantsData as ConstantsData;