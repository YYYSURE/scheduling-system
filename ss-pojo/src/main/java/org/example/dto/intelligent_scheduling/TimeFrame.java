package org.example.dto.intelligent_scheduling;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

//时间段 TODO 哪里生成的?
@Data
@NoArgsConstructor
public class TimeFrame {

    /**
     * 最早时间
     **/
    Time earliestTime;
    /**
     * 最晚时间
     **/
    Time latestTime;
    /**
     * 这个范围的时长(h)
     **/
    double duration;

    public TimeFrame(Time earliestTime, Time latestTime) {
        if (latestTime.compareTo(earliestTime) < 0) {
            throw new RuntimeException("TimeFrame Init Error: latestTime < earliestTime ! " + latestTime + " < " + earliestTime);
        }
        this.earliestTime = earliestTime;
        this.latestTime = latestTime;
        this.duration = latestTime.diff(earliestTime);
    }

    public static TimeFrame copy(TimeFrame t) {
        TimeFrame timeFrame = new TimeFrame();
        timeFrame.duration = t.duration;
        timeFrame.earliestTime = Time.copy(t.earliestTime);
        timeFrame.latestTime = Time.copy(t.latestTime);
        return timeFrame;
    }

    public static TimeFrame[] copy(TimeFrame[] ts) {
        if (ts == null) {
            return null;
        }
        TimeFrame[] timeFrames = new TimeFrame[ts.length];
        for (int i = 0; i < timeFrames.length; i++) {
            timeFrames[i] = TimeFrame.copy(ts[i]);
        }
        return timeFrames;
    }

    @Override
    public String toString() {
        return "TimeFrame{" +
                "earliestTime = " + earliestTime +
                " , latestTime = " + latestTime +
                " , duration = " + duration + " min" +
                '}';
    }
}
