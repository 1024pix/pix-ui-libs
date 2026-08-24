const repositoryUrl = "https://github.com/1024pix/pix-ui-libs/ember/nebulix";
const pkgName = "@1024pix/ember-nebulix";
const pkgRoot = "./ember/nebulix";
const tagFormat = `${pkgName} v${version}`;
const changelogTitle = `# ${pkgName}`;
const changelogFile = `${pkgRoot}/CHANGELOG.md`;

module.exports = {
  branches: ["dev", "hotfix.*"],
  repositoryUrl,
  tagFormat,
  plugins: [
    // Analyse les commits pour definir la nouvelle version
    [
      "@semantic-release/commit-analyzer",
      {
        config: "@1024pix/conventional-changelog-pix",
        releaseRules: [
          { revert: true, release: "patch" },
          { tag: "BUGFIX", pr: "*", release: "patch" },
          { tag: "BUMP", pr: "*", release: "patch" },
          { tag: "DOC", pr: "*", release: "patch" },
          { tag: "TECH", pr: "*", release: "patch" },
          { tag: "FEATURE", pr: "*", release: "minor" },
          { tag: "BREAKING", pr: "*", release: "major" },
        ],
      },
    ],
    // Génère un changelog à partir des commit de la release
    [
      "@semantic-release/release-notes-generator",
      {
        config: "@1024pix/conventional-changelog-pix",
      },
    ],
    // Modifie le fichier changelog
    ["@semantic-release/changelog", { changelogTitle, changelogFile }],
    // Publie la release dans github (avec le changelog)
    "@semantic-release/github",
    // Publie la release sur npm
    ["@anolilab/semantic-release-pnpm", { pkgRoot, publishBranch: "dev" }],
    // Crée le commit de release sur la branche principale
    [
      "@semantic-release/git",
      {
        assets: [
          "package.json",
          "pnpm-lock.json",
          `${pkgRoot}/package.json`,
          changelogFile,
        ],
        message:
          "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}",
      },
    ],
  ],
};
