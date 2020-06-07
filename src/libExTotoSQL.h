#ifndef MUNDUS_EX_TOTO_SQL_LIBEXTOTOSQL_H
#define MUNDUS_EX_TOTO_SQL_LIBEXTOTOSQL_H

#ifdef __cplusplus

#include <memory>
#include <ctime>
#include <atomic>

#define MYSQLPP_MYSQL_HEADERS_BURIED 1
#include <mysql++/mysql++.h>
#include <mysql++/connection.h>

namespace extotosql {

typedef mysqlpp::Query Query;
typedef mysqlpp::Exception Exception;

class FSExTotoSQL;
typedef FSExTotoSQL *filesystem_t;

class MundusExTotoSQL : public mysqlpp::Connection {
public:
    MundusExTotoSQL();
    ~MundusExTotoSQL();

    MundusExTotoSQL(const MundusExTotoSQL&);
    MundusExTotoSQL& operator=(const MundusExTotoSQL&);

    MundusExTotoSQL(MundusExTotoSQL&&);
    MundusExTotoSQL& operator=(MundusExTotoSQL&&);

private:
    //std::unique_ptr<mysqlpp::Connection> _connection;
};

}

extern "C" {
#endif

/* C exports */


#ifdef __cplusplus
}
#endif

#endif /* MUNDUS_EX_TOTO_SQL_LIBEXTOTOSQL_H */