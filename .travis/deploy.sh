(
mkdir out
cd out
git init
git config user.name "Travis-CI"
git config user.email "build@travis-ci.org"
cp ../main.pdf ./
mkdir sitzungsprotokolle
cp ../content/projektmanagement/sitzungsprotokolle/protokoll-*.pdf ./sitzungsprotokolle
git add .
git commit -m "Deployed to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/upd89/doc.git" master:gh-pages > /dev/null 2>&1
)
