# Daheen's Journey to iOS developer :airplane:

This blog is for archiving what I learn every day. The posts are usally about iOS contents including Swift, HIG, Xcode, and often programming generals such as Design Pattern, Algorithm, and so on.

&nbsp;

&nbsp;

## :wrench: Setting up the first jekyll blog

#### Theme [centrarium](https://github.com/bencentra/centrarium)

&nbsp;

#### Custom Setting

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

9. Logo image custom - favicon

   - [favicon 생성 사이트](https://www.favicon-generator.org/)
   - [참조](https://webdir.tistory.com/337)
   
10. google analytics 추가 (2019.05.21)

   - Config 에 tracking id 추가, ...

   - [참조 사이트](https://rextarx.github.io/jekyll/2017/02/03/Applying_Google_Analytics_to_a_blog_using_Jekyll/)

11. google 검색 추가 (2019.05.21)

    - sitemap.xml 추가
    - [참조 사이트](https://wayhome25.github.io/etc/2017/02/20/google-search-sitemap-jekyll/)
    - [참조 사이트](https://gmlwjd9405.github.io/2017/10/20/include-blog-in-a-GoogleSearchEngine.html)
    
12. draft folder 추가 (2019.05.10)

13. heading font 수정 (2019.05.28)

    - 파일 경로 : `_sass/base/_variable.scss` 
    - 변수명: `$heading-font-family`
    - font : Roboto Slab → Open Sans

14. Tags archive page 추가 (2019.05.29)

    - `post.html` 참조함
    - `site.tags` 로 변수만 수정

&nbsp;

&nbsp;

### :bookmark: To Do Later

- GitHub badges
  - [shields.io](https://github.com/badges/shields)
- <s>draft 사용해보기</s>
- <s>Tag archive page</s>