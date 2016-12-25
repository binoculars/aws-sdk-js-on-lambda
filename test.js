import fs from 'fs';
import * as packageJson from './package.json';
import test from 'ava';

const responseVersion = fs.readFileSync('./remote_version', {encoding: 'utf8'});

test('it should have the correct version', t => {
	t.is(packageJson.version, responseVersion);
	t.is(packageJson.dependencies['aws-sdk'], responseVersion);
});