# Global module

HEADERS += $$SK_CORE/global/Sk_p.h \
           $$SK_CORE/global/Sk.h \

SOURCES += $$SK_CORE/global/Sk_p.cpp \

!lib:SOURCES += src/global/main.cpp \
