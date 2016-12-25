#!/usr/bin/env node

const fs = require('fs');
const https = require('https');

function request(url) {
	return new Promise((resolve, reject) => {
		const request = https.get(url, response => {
			if (response.statusCode < 200 || response.statusCode > 299)
				return reject(new Error('Failed to load page, status code: ' + response.statusCode));

			let body = '';
			response.on('data', chunk => body += chunk);
			response.on('end', () => resolve(body));
		});

		request.on('error', reject);
	});
}

const lambdaVersionsUrl = 'https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html';

request(lambdaVersionsUrl)
	.then(response => {
		const responseVersion = response.match(/version (\d+\.\d+\.\d+)/)[1];
		fs.writeFileSync('./remote_version', responseVersion);
	});