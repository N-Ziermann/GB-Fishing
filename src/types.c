struct fish {
  UINT8 x;
  UINT8 y;
  UINT8 sprites[2];
  INT8 index;
};

struct can {
  UINT8 x;
  UINT8 y;
  UINT8 sprite;
  UINT8 moveEveryXFrames;
};

struct rod {
  UINT8 yHook;
  UINT8 hookSprite;
  UINT8 hookSpriteFish;
  UINT8 spriteTile;
};

typedef struct fish Fish;
typedef struct rod Rod;
typedef struct can Can;
typedef enum { false, true } bool;