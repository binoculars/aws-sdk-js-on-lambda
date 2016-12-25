# aws-sdk-js-on-lambda
> The current aws-sdk-js version on AWS Lambda, useful for testing

[![Build Status](https://travis-ci.org/binoculars/aws-sdk-js-on-lambda.svg?branch=master)](https://travis-ci.org/binoculars/aws-sdk-js-on-lambda)

## Usage
If you already have the aws-sdk installed as a devDependency, remove it.

### NPM
npm v3 or later is required (flat dependencies).

```shell
npm i -g npm@latest && \
npm r -D aws-sdk && \
npm i -D binoculars/aws-sdk-js-on-lambda
```

### Yarn
```shell
yarn remove aws-sdk && \
yarn add --dev binoculars/aws-sdk-js-on-lambda && \
yarn install --flat
```

### In your code
As you normally would...

```js
const AWS = require('aws-sdk');
// or
import AWS from 'aws-sdk';
````
