#ifndef IMAGE_STREAMER_2D_HPP
#define IMAGE_STREAMER_2D_HPP

#include "SmartPointers.hpp"
#include "Streamer.hpp"
#include "DynamicImage.hpp"
#include <boost/thread.hpp>

namespace fast {

class ImageStreamer : public Streamer {
    FAST_OBJECT(ImageStreamer)
    public:
        DynamicImage::pointer getOutput();
        void setFilenameFormat(std::string str);
        void setDevice(ExecutionDevice::pointer device);
        // This method runs in a separate thread and adds frames to the
        // output object
        void producerStream();

        ~ImageStreamer();
    private:
        ImageStreamer();

        // A reference to the output object used to update its next frame
        DynamicImage::pointer mOutput;
        WeakPointer<DynamicImage> mOutput2;

        // Update the streamer if any parameters have changed
        void execute();


        boost::thread *thread;

        bool mStreamIsStarted;
        bool mFirstFrameIsInserted;

        std::string mFilenameFormat;

        ExecutionDevice::pointer mDevice;

};

} // end namespace fast

#endif