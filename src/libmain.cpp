
#include "libExTotoSQL.h"

#include <cstdio>

namespace {

void __attribute__((constructor, visibility("hidden"))) _init();
void __attribute__((destructor, visibility("hidden"))) _fini();

void _init()
{
    fprintf(stderr, "libExTotoSQL: _init()\n");
}

void _fini()
{
    fprintf(stderr, "libExTotoSQL: _fini()\n");
}

}

namespace extotosql {

MundusExTotoSQL::MundusExTotoSQL() : mysqlpp::Connection(true) {

}

MundusExTotoSQL::~MundusExTotoSQL() {

}

MundusExTotoSQL::MundusExTotoSQL(const MundusExTotoSQL&) {

}

MundusExTotoSQL& MundusExTotoSQL::operator=(const MundusExTotoSQL&) {
    return *this;
}

MundusExTotoSQL::MundusExTotoSQL(MundusExTotoSQL&&) {

}

MundusExTotoSQL& MundusExTotoSQL::operator=(MundusExTotoSQL&&) {
    return *this;
}

}
