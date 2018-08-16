#!/bin/sh
cd `dirname $0`
VERSION=$1
if [ -z "$VERSION" ]; then
	echo "Missing version on command line!" >&2
	exit 1
fi
dotnet pack \
	-p:Title="Activout Rest Client" \
	-p:Description="Create a REST(ish) API client only by defining the C# interface you want." \
	-p:PackageVersion="$VERSION" \
	-p:PackageLicenseUrl="https://raw.githubusercontent.com/twogood/Activout.RestClient/master/LICENSE" \
	-p:PackageProjectUrl="https://github.com/twogood/Activout.RestClient" \
	-p:RepositoryType="git" \
	-p:RepositoryUrl="https://github.com/twogood/Activout.RestClient.git" \
	--configuration=Release \
	--include-symbols \
	--include-source \
	Activout.RestClient/Activout.RestClient.csproj
