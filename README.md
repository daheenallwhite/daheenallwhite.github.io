# Daheen's Journey to iOS developer :airplane:



# Setting up the first jekyll blog

#### Reference

- Theme - [centrarium](https://github.com/bencentra/centrarium)



### Costume Setting

1. 초기 설정 - config, theme, remote 등등...

   - [참조](https://gmlwjd9405.github.io/2017/10/06/Jekyll-github.io-blog-1.html)

2. jekyll admin plugin

   -  [참조](http://labs.brandi.co.kr/2018/05/14/chunbs.html)

3. Emoji & css - layout.scss 에서 수정함

   - [jemoji](https://github.com/jekyll/jemoji)

   - emoji width 한 줄 다 차지하는 문제 해결 - css 수정 내용 : emoji class css 

     ```css
     .page-content {
     	...
     	.emoji {
     		display: inline;
     		border-radius: 0px
     		width: auto
     	}
     }
     ```

4. css - blockquote - typography.scss에 고침

   - blockquote style - 참조사이트에서 참고하여 몇가지 빼고 사용
   - [참조한 스타일](https://css-tricks.com/snippets/css/simple-and-nice-blockquote-styling/)

5. Social 

   - Config 파일에서 수정
   - footer 에서는 주소값이 있는 애들만 가져오길래 linkedin 주소 지워서 해결함

6. main cover image

   - asset에 header_image

7. config - 미래 날짜 post 도 표시되도록

   - `future: true`  추가

8. about.md 수정

&nbsp;

&nbsp;

### To Do Later

- GitHub badges
  - [shields.io](https://github.com/badges/shields)
- draft 사용해보기
- Tag 
- category