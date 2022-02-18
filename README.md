# mix-inject-env

`mix-inject-env` is a tool that allows you to inject your environment variables after building the static files, allowing you to deploy the same build to multiple environments quickly.

`mix-inject-env` is [react-inject-env](https://github.com/codegowhere/react-inject-env) forked project for [laravel-mix](https://laravel-mix.com/).

## Usage

### 1. Install mix-inject-env

```
npm install mix-inject-env --save-dev
yarn add mix-inject-env --dev
```

### 2. Update Code

- Add the following to `/resources/views/layouts/app.blade.php`

```html
<script src='/js/env.js'></script>
<script src="{{ mix('/js/app.js') }}" defer></script>
```

- Create a new file called `/resources/js/env.js` and copy the following code:

```js
export const env = { ...process.env, ...window.env }
```

- Replace all instances of `process.env` with the newly created `env` variable

```jsx
import { env } from './env'

window.Echo = new Echo({
    broadcaster: 'pusher',
    key: env.MIX_PUSHER_APP_KEY,
    cluster: env.MIX_PUSHER_APP_CLUSTER,
    forceTLS: true
});
```

### 3. Build your static files

The command should be `npm run dev` or `npm run prod`.

### 4. Inject environment variables

```
[env variables] npx mix-inject-env set
```

Pass in all your environment variables.

```shell
# with a black background
MIX_PUSHER_APP_KEY=app-id MIX_PUSHER_APP_CLUSTER=cluster-info npx mix-inject-env set

# for windows
set MIX_PUSHER_APP_KEY=app-id&& set MIX_PUSHER_APP_CLUSTER=cluster-info&& npx mix-inject-env set
```

### Additional options

`-d / --dir`: The location of your static build folder. Defaults to `./public/js`

`-n / --name`: The name of the env file that is outputted. Defaults to `env.js`

`-v / --var`: The variable name in `window` object that stores the environment variables. The default is `env` (window.**env**). However if you already have a variable called `window.env`, you may rename it to avoid conflicts.

## .env / dotenv

`.env` files are supported. `mix-inject-env` will automatically detect environment variables in your `.env` file located in your root folder.

Note: Environment variables passed in through the command line will take precedence over `.env` variables.

## Typescript

In step #2, create a file called `env.ts` instead of `env.js`

```ts
declare global {
  interface Window {
    env: any
  }
}

// change with your own variables
type EnvType = {
  MIX_COLOR: string,
  MIX_MAIN_TEXT: string,
  MIX_LINK_URL: string,
  MIX_LOGO_URL: string
}
export const env: EnvType = { ...process.env, ...window.env }
```

## Docker / CICD

`npx mix-inject-env` works well with both Docker and CI/CD.

```dockerfile
FROM php:8-fpm-alpine

RUN apk nodejs npm && \
    npm install mix-inject-env --save-dev

ENTRYPOINT npx mix-inject-env set && php-fpm
```

```shell
docker build . -t mix-inject-env-sample-v2

docker run -p 8080:8080 \                   
-e MIX_COLOR=yellow \
-e MIX_LOGO_URL=./logo512.png \
-e MIX_MAIN_TEXT="docker text" \
-e MIX_LINK_URL=https://docker.link \
mix-inject-env-sample-v2
```

## Information

### Why do I need this?

A typical CI/CD process usually involves building a base image, followed by injecting variables and deploying it. 

Unfortunately React or Laravel Mix applications does not allow for this workflow as it requires environment variables to be present before building it. 

There have been a few workarounds, with the most common solution being to load environment variables from an external source. However this now causes the additional problem that environment variables can only be accessed asynchronously.

### Goals

`mix-inject-env` attempts to solve this problem in the simplest, and most straightforward way with the following goals in mind:

1. Does not require a rebuild
2. Minimal code change required
3. Allows synchronous access of environment variables
4. Supports a wide amount of tools and scripts
5. Works with command line environment variables
6. Simple and straightforward

### Compatibility

`mix-inject-env` was built with support for both `laravel-mix` and `dotenv`. 

However due to the simplicity of it, it should work with almost all scripts and tools.
