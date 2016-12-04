import https from 'https';
import * as packageJson from './package.json';
import test from 'ava';

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

test('it should have the correct version', async t => {
	const response = await request(lambdaVersionsUrl);
	const responseVersion = response.match(/version (\d+\.\d+\.\d+)/)[1];

	t.is(packageJson.version, responseVersion);
	t.is(packageJson.dependencies['aws-sdk'], responseVersion);
});