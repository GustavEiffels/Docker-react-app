# builder 를 붙임으로 Build Stage 임을 명시
FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
# 종속성 추가
RUN npm install
COPY ./ ./
# build file 들을 container 안에 생성 
RUN npm run build

FROM nginx
# builder 라는 stage 에 옴
COPY --from=builder  /usr/src/app/build /usr/share/nginx/html