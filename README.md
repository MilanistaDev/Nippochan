# Nippochan(日報ちゃん)

## Commentary article

https://qiita.com/MilanistaDev/items/b97cab77d6add96c96dc

## Summary
This is a sample app that can post daily report to Slack
by using Watch Connectivity and Slack's webhook URL.
For Apple Watch and iOS Devices.

## Conceptual diagram

<img width="897" alt="日報ちゃん概念図.png" src="https://qiita-image-store.s3.amazonaws.com/0/88266/752e2048-5cb9-8ec5-f8a5-27a38866027a.png">

## Screen shots

iPhone has six screens and Apple Watch has only one screen.

<img width="869" alt="App画面数.png" src="https://qiita-image-store.s3.amazonaws.com/0/88266/d7aa732a-127d-f925-79ba-81255b8b22a5.png">

**Slack Post**

<img width="913" alt="result.png" src="https://qiita-image-store.s3.amazonaws.com/0/88266/a38fa406-06bc-8852-2b07-84dc28c8cbca.png">

## Language
* Swift 4.2
* watchOS 5.0 and later
* iOS 10 and later

## Installation

Please download zip file or use git clone.

```
$ cd ~/Download
$ git clone git@github.com:MilanistaDev/Nippochan.git
```

## Usage
1. Open project file by using Xcode.app.
2. Push the Run button.
3. Please install Watch App via Watch.app of iPhone.
4. At first, please input your profile data.
5. And then please input slack setting data, too.
6. Finally, add words you want to post.
7. Run Apple Watch's App and tap the **Share data with Watch** button.
8. If success, the word list is sent to Apple Watch.
9. Please select word by using Digital Crown and tap bottom button.
10. Enjoy!

## Contributing
If you find bugs, please send pull-request.

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History
| Version | Date |
|:--:|:--:|
|ver 1.0.0 | December 25, 2018 |

## Credits
Takuya Aso, 2018
milanista224☆me.com　☆ -> @

## License
Based on the GitHub License.
