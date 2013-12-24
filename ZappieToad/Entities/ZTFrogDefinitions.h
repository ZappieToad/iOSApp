
typedef enum _ZTDirection {
    kZTDirectionUp = 0,
    kZTDirectionLeft = 1,
    kZTDirectionDown = 2,
    kZTDirectionRight = 3,
    kZTDirectionUnknown,
} ZTDirection;

typedef struct _ZTGridXY {
    int x;
    int y;
} ZTGridXY;

// Forward declaration for the frog type
@class ZTFrog;

// This block is a general completion handler (callback) that may be invoked when longstanding
// operations involving the frog are completed.
typedef void (^ZTFrogCompletionBlock)(ZTFrog *frog);
