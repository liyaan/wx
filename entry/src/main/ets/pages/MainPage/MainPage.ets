import { MainPage } from 'library'
import router from '@ohos.router';

@Entry
@Component
struct Index {
  onBack() {
    router.back()
  }

  build() {
    Column() {
      MainPage()
    }
    .height('100%')
    .width('100%')
  }
}