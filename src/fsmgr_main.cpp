#include "libExTotoSQL.h"

#include <iostream>
#include <type_traits>

int main(int, char**) {
    extotosql::MundusExTotoSQL fs;
    try {
        fs.connect("extotosql", "/run/mysql/mysql.sock", "root", "root");
    } catch (const extotosql::Exception &ex) {
        const std::type_info &ex_type = typeid(ex);
        std::cerr << "Caught extotosql::Exception [" << ex_type.name() << "] : " << ex.what() << std::endl;
        return fs.errnum();
    }

    return 0;
}