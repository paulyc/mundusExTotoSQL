#include "libExTotoSQL.h"

#include <optional>

namespace {

class GenericObjectRevset;

class GenericObject {
public:
    uint64_t id;
    struct timespec create_timestamp;
    std::list<std::shared_ptr<GenericObjectRevset>> revsets;
};

class GenericObjectRevset {
public:
    uint64_t id;
};

}

namespace extotosql {

class FSExTotoSQL {
public:
    typedef __uint128_t uuid_t;

    FSExTotoSQL() :
        FSExTotoSQL(std::nullopt) {

    }

    FSExTotoSQL(uuid_t uuid) :
        FSExTotoSQL(std::make_optional(uuid)) {

    }

    FSExTotoSQL(std::optional<uuid_t> uuid_opt) :
        _fs_uuid(uuid_opt),
        _load_sync(false),
        _store_sync(false) {

    }

    void sync(MundusExTotoSQL &mundus) {
        if (_fs_uuid.has_value()) {
            // try to load fs with this uuid
            mundus
        }
    }
    void commit(MundusExTotoSQL &mundus) {

    }
    void rollback(MundusExTotoSQL &mundus) {

    }

    static constexpr const char *_q_filesystem_by_uuid_sql =
        "SELECT"
        "    `fsmeta`.`object_id`,"
        "    `fsmeta`.`fs_uuid`,"
        "    `fsmeta`.`version`,"
        "    `fsmeta`.`root_directory_object_id`,"
        "    `gobj`.`create_revset_id`,"
        "    `gobj`.`current_revset_id`,"
        "    `gobj`.`revset_count`"
        "  FROM `filesystem_metadata` `fsmeta`"
        "  INNER JOIN `generic_object` `gobj`"
        "    ON `fsmeta`.`object_id` = `gobj`.`id`"
        "  WHERE `fsmeta`.`fs_uuid` = ?";

    std::optional<uuid_t> _fs_uuid;
    std::atomic_bool _load_sync;
    std::atomic_bool _store_sync;
};

}

