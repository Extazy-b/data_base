#include <sqlite3ext.h>
SQLITE_EXTENSION_INIT1

void power_surplus(sqlite3_context* context, int argc, sqlite3_value** argv) {
    double power = sqlite3_value_double(argv[0]);
    sqlite3_result_double(context, power * 1.2);
}

int sqlite3_extension_init(sqlite3 *db, char **pzErrMsg, const sqlite3_api_routines *pApi) {
    SQLITE_EXTENSION_INIT2(pApi)
    sqlite3_create_function(db, "POWER_SURPLUS", 1, SQLITE_UTF8, NULL, power_surplus, NULL, NULL);
    return SQLITE_OK;
}
