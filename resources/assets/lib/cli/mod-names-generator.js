// Copyright (c) ppy Pty Ltd <contact@ppy.sh>. Licensed under the GNU Affero General Public License v3.0.
// See the LICENCE file in the repository root for full licence text.

'use strict';

const fs = require('fs');

const root = `${__dirname}/../../../..`;

function modNamesGenerator() {
  const modsByRuleset = JSON.parse(fs.readFileSync(`${root}/database/mods.json`));

  const modNames = {};
  for (const mods of modsByRuleset) {
    for (const mod of mods.Mods) {
      modNames[mod.Acronym] = mod.Name;
    }
  }

  fs.writeFileSync(`${root}/resources/assets/build/mod-names.json`, JSON.stringify(modNames));
}

module.exports = modNamesGenerator;
